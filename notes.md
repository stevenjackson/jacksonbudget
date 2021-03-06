# Apr 10 2021

Coming back to this project has been a lot of - what was I trying to do?  Where are we?  What is this thing?

There's an android app.  It lets you sign in with google and pass a token on your web requests.  I think that's it honestly.  Oh it has a list view.

I have a phoenix app for serving json.  As I recall this was an excuse to use phoenix and I got hung up on how/where to deploy the darn container.

It looks like I started a loader that will throw text files up for the phoenix app (wherever it lives) to work with

Coming back to this I'm struck by how much I just don't understand the elixir ecosystem.  I'm still unsure that it's a good direction for this, but there's so little "actual code" that I don't think it matters.  This whole thing could run in a lambda if it weren't for my vanity.


## Here's what I've identfied today:

* I want secure access to the data files
* I kinda/sorta want to keep elixir, but getting more ambivalent.  My interest is waning as I want to do elixir but I want to do massively parallel elixir not lame "serve json" elixir.
* I sorta/kinda want to keep docker to play with those deployment services.
* I'd prefer AWS
* I already need/have a google project to do the auth stuff in android.

## So with all that, here's where I'm leaning.

* Google Cloud Storage for files.  Presumably this can be accessed s3 style using ids and secrets.
* Docker container runnning phoenix for now, deployed using Google Cloud Run.  It's supposed to be free and can't be that different from ECS.  Getting comfortable just deploying containers means I can try different things here.
* I'd like to investigate terraform as an option so I can potentially try migrating something from google to aws and getting some experience with that.  But that might make me sad that still nothing is getting shipped.
* My upload app might just turn into a POST with magic credentials for now.  I have to bend somewhere and I'm the one uploading the data.

## Next steps

I need to break this down so I can A) get something end-to-end and B) work on it 20 mins at a time.

### Does android app work in an emulator?  What does it do?
It does the sign in and is trying to call the "server" to get json.  That needs to work to see anything else.

### Can I use the phoenix app as-is right now?  Does it return json outside it's container?
After a few fixes, mostly.

### Deploy that app using Google Cloud Run.  See dummy data at a publically acccessible endpoint.
This has been a thing.

Started off trying to configure Cloud Run.

There's a built-in way to do this from repo pushes, but building the container requires all your secrets to be accesssible.  Since I didn't want to commit those , I opted for pushing the images myself, though configuring the secrets somewhere in google is probably an option.
To push images need to install gcloud apis:
```
brew install -cask google-cloud-install
gcloud auth login
gcloud config set project jackson-budget-1519498484201
gcloud services enable containerregistry.googleapis.com
gcloud auth configure-docker
```
Plus some changes around giving the service account the IAM roles it needs.  Not sure what was necessary there, but it's a mess.

Added a publish task to `docker tag` and `docker push` the image.

Now back to cloud run, can I use the latest image?
Yes!
----

### Lock down the endpoint (static)  or make it settable in the android app.
This seems to work?  Cloud run gave me an endpoint and I injected it into secrets for the android app.  As far as I can tell from the docs, this is a permanent assignment.

### Serve dummy data from container in android app.
[x] - Done

### Investigate regenerate the phoenix app rather than working with 3 year old tech?
[x] - Done.  This was a little more than I hoped, but I'm super excited that the elixir/phx ecosystem has moved on.  With `mix release` I no longer need distillery and phoenix now has top-level docs on how to get integrated with docker and configure to pass in runtime secrets.
https://hexdocs.pm/phoenix/releases.html#containers Good stuff!  Live Dashboard looks cool too, though I doubt I will use it

### get SECRET_KEY_BASE into the container
[x] - Done this was really easy.  Since I don't have "auto" deploys wired up yet I had to go to cloud run anyway to change my image.  There's a tab for variables.

### Re-enable auto deploys (gh webhooks) now that we don't need secrets at build time
Done.  This generated something called a cloudbuild.yaml file that was not quite right for my strange package structure.  I decided to copy/paste/hack that into version control rather than trying to ever find it again.

### Investigate uploading some kind of file to Google Cloud Storage and restricting access.
This seems to be pretty easy - buckets are non-public and access prompts for google login.  I feel like I'm missing something, it's too easy.

### Accessing Google Cloud Storage from elixir
Found this. https://github.com/googleapis/elixir-google-api
Had some issues trying to figure out how to get started.  It seems like there's a `goth` library that handles the auth part of the connection.  And it supposedly has a flow that uses "Application Default Credentials" https://cloud.google.com/docs/authentication/production but all the examples make it seem like this is ignored and explicit configuration is the way.

Ran:
`gcloud auth application-default login`

This seems to have generated a json file.  I'm going to see if I can inject this in my dev configs.

This is the wrong thing as it creates a refresh token based file and I probably want a service account.

I'll try and do this like the goth README seems to want and then bail back to 1.2 if that doesn't work.

Ok, seem to have goth working locally.

Parsing still takes some work because I'm not great at elixir

### Serve processed data from GCS in android app
Working after fixing some goth issues

### Reject requests that aren't from laura or me.
### Load android app on laura's phone see dumb data.
### Put "real" data in google cloud storage - see on phone.
### Can no longer run docker locally because we can't access GCS (either need to map in local file or pass env credentials, I guess)
=== v1 ready ====


### Add upload endpoint locked to me - somehow.
### Verify updates update the app.
=== v2 ready ====


