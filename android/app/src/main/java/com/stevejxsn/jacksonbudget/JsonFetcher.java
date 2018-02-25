package com.stevejxsn.jacksonbudget;

import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by stevejackson on 2/25/18.
 */

public class JsonFetcher {

    private final String idToken;
    private final RequestQueue queue;

    public JsonFetcher(Context context, String idToken) {
        this.queue = Volley.newRequestQueue(context);
        this.idToken = idToken;
        queue.start();
    }

    public void fetch(String url, Response.Listener<JSONObject> callback, Response.ErrorListener errorListener) {
        final JsonFetchRequest request = new JsonFetchRequest(url, callback, errorListener);
        Log.i("JsonFetcher", "request added");
        queue.add(request);
    }

    private class JsonFetchRequest extends JsonObjectRequest {
        public JsonFetchRequest(String url, Response.Listener<JSONObject> listener, Response.ErrorListener errorListener) {
            super(Request.Method.GET, url, null, listener, errorListener);
        }

        @Override
        public Map<String, String> getHeaders() throws AuthFailureError {
            Map<String, String> headers = new HashMap<String, String>(super.getHeaders());
            headers.put("X-Auth-Token", idToken);
            return headers;
        }
    }
}
