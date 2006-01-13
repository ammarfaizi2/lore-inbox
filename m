Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423053AbWAMWgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423053AbWAMWgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423057AbWAMWgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:36:12 -0500
Received: from sipsolutions.net ([66.160.135.76]:45841 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1423053AbWAMWgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:36:10 -0500
Subject: Re: wireless: recap of current issues (actions)
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060113222512.GN16166@tuxdriver.com>
References: <20060113195723.GB16166@tuxdriver.com>
	 <20060113212605.GD16166@tuxdriver.com>
	 <20060113213311.GI16166@tuxdriver.com>
	 <20060113222512.GN16166@tuxdriver.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Hsuvyh0C7jkvO5uXtjq6"
Date: Fri, 13 Jan 2006 23:36:05 +0100
Message-Id: <1137191765.2520.71.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hsuvyh0C7jkvO5uXtjq6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-01-13 at 17:25 -0500, John W. Linville wrote:

> Since we are toying with the issue of multiple stacks (at least in the
> wireless development kernels), some thought needs to be done w.r.t. how
> to make a final decision between the two stacks.  An objective lists
> of functional feature requirements seems like a good place to start.
> IOW, I would like to have a list of features that would trigger the
> removal of one stack shortly after the other stack achieves support
> for the list.  Is this feasible?

I started collecting some info on
http://johannes.sipsolutions.net/802.11_stacks
That page should probably be moved somewhere (netdev wiki?) where it is
writable by others. I also need to update it to include comments by Jean
Tourrilhes.

johannes

--=-Hsuvyh0C7jkvO5uXtjq6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ8grUqVg1VMiehFYAQLOwQ/+N224/SglNCCoq2qJnXEPWWdaQ/NRJCID
UhjlDR6/rlm+x/R3uEUNPPZEjslZDNbQ58CsiEHzWHZFG1W7gXpnCtNa/iVkthxe
e0AXf5BpCuSbTamMRZOh930os1tM6WDJtxt3GIYRMeuc9Byq5PWq9SVyD1wzA8aI
09NkUMa9jC/3vmuXnJ0Ej96+/HvL37ofvNnce3/k8Idqvmto65q4galzjGyUKks6
FjWjJfuIHxD8Qq9KZcu7hVTmgbjPWomvFrztxwwnpZim52KD3xrL9onLM4Dcvgo/
maHWSRqgJVJcyQHnG4g4FBvvr3EK5DUJcijsbE4fEi62v48jEd75sXLHv0tMxxAf
NygTqGeRVhzhYZkh+yRt/78rOkaFuuejpGZBZ74aVK7gPjuT2VqA0InaivBhrBuY
N67InAFlRdzuXc0Jp1fDbFac0pbkDBr5CxF8QGjmN/x452gqTs+GNysjdOU7yWra
ASNEOr2LD1BdcfqRT7vqg+Aw1R37Wp/g6nkwPCjtj/iV18jwVHyUO4QamarYpTmu
+krpwRYH4MYCDWYpCLhoROB1j/wBF4EOeYYqJLgoXLWEqCoNxg9lkTDZwp7ydrfG
1h01lq2pe75Oaggmfgq/wvX3Ffbr0uBYComblWPv6XjBrursgfqaXV2RCmPj5a1S
1ZhWzUdPZWE=
=62sS
-----END PGP SIGNATURE-----

--=-Hsuvyh0C7jkvO5uXtjq6--

