Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVLNN5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVLNN5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVLNN5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:57:24 -0500
Received: from sipsolutions.net ([66.160.135.76]:2832 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S964779AbVLNN5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:57:24 -0500
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch
	driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, stelian@popies.net, kernel-stuff@comcast.net
In-Reply-To: <20051213223659.GB20017@hansmi.ch>
References: <20051213223659.GB20017@hansmi.ch>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c8hZw2F4XerfqUK5HNfo"
Date: Wed, 14 Dec 2005 14:57:00 +0100
Message-Id: <1134568620.3875.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c8hZw2F4XerfqUK5HNfo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-12-13 at 23:36 +0100, Michael Hanselmann wrote:
> +module_param(relayfs, int, 0644);

Why do you make the parameter writable if writing it doesn't change
anything?

johannes

--=-c8hZw2F4XerfqUK5HNfo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ6AkpqVg1VMiehFYAQKm1Q/+Kg15S36YLB/p7hJtyjG9m1eRcdpnHK6l
RLyOev+yW6vpKPrPHZSv/Babzv69SAnYBeoJYhYUnKqU/ylYtOyE5UKkU13yxwLG
Hsv+gk4AkZ7rZ/KrfV2+gG/qN0NxuLLNAeeZecjL2dkYTxZR+KWInFPIsPV2f2Fk
anNpKLruDPRIyWJVybwR34M+Ma7DrJCG/ZlIcUfn4mROyOHNNJFTrBg8kFuBBCJQ
hbcDRE8ZLm6q/4JgOT6SLZg/npbRt9SBenKGSUJsEbgbQdsYuKVMeH92ya3p6n3s
j2K/9NhhqS1sW8Fo3OcGjO4RLVM2E4n2w+bs6XftnjhOayvAqEAxa/5DB9R4QJZQ
aXBXuN4QU7W0o5Sr9IEUieZ9Od2GzHuC6+6q2YI+2Omky5ZBFjbEFJuqE54WnmnJ
+PZup+3HbWU2rdVn0s7tiGBKuwLZ+dmWKSKefOdRfTALlkwfcypd5QG9hicX62x9
UfP2vR9mMq8JPvguwFUKrEOWYVNRWEHX6LsDOLDavT/SxyeiOVx/iXnva1AhKVTW
2IPToK9yi+d3Nmwzlpfb1njHmp5P44KeKi09kNQqaYh+5lRnj7Cv7miXyCbdY04P
MF4jsJeHccZmB5mXuJw4YsTQ284cJllvkRGiIbXRNu6TPyrxplAPPrCVuLJ3SspA
aE0ITnyqrmU=
=Lanv
-----END PGP SIGNATURE-----

--=-c8hZw2F4XerfqUK5HNfo--

