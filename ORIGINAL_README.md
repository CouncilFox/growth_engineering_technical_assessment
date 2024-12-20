# Growth Engineering Technical Assessment

This assessment is meant to give candidates an opportunity to show off their
abilities to quickly and effectively stand up "demo ready" environments and
applications to be shown to a potential Customer at an in-person event.  The
quality of the delivery is meant to meet the standards of a single-day, but
multiple use, demo environment e.g. setup and tear down should be easy enough
that re-deploying the environment can be done while customer watches.

## Prerequisites

_A working Kubernetes_: This can be a local cluster as provided by Docker
Desktop, k3d, kind, or otherwise.  It could also be managed Kubernetes such as EKS,
AKS, or DOKS.  Please specify which in your submission below:

Kubernetes "flavor" used in submission: `<Your K8s Flavor Goes Here>`

**DO NOT** rely on additional cloud-provided managed services for your submission.
The grader will be evaluating your submission in their local infrastructure
which will likely differ from your environment and it is expected to work for
them as well.  The intent for providing your flavor is to help resolve any
"surprising" results of a managed K8s provider.

## Assignment

Make a copy of this Template Repository to your own GitHub account and work
within it.  Please push early and often though you will be submitting a single
compressed artifact of the repository (see [Deliverables](#deliverables) below).

You will build and deploy the small Golang API as implemented in `app/` to your
Kubernetes cluster.

If the containerized application requires an external registry to
(temporarily) host the image use [`ttl.sh`](https://ttl.sh) with no more than a
2h TTL.

## Deliverables

When you are done please return a `.tar.gz` or `.zip` compressed copy of your
work (including the `.git/` directory) to the hiring manager by way of email.
That copy will be graded but please _also_ push your changes to your copy of the
template repository (and include the URL in your email) as a backup plan (in
case the compressed file gets corrupted or otherwise is unusable).

* [ ] Updated README with any updates required for the grader to evaluate your
  solution.

* [ ] A _single command_ to build and deploy the application to a Kubernetes
  cluster.

Setup/Deploy Command: `<your command here>`

* [ ] A _single command_ to tear down the application to return the cluster to
  its original state.

Teardown Command: `<your command here>`
