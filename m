Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTL2Pyx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 10:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTL2Pyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 10:54:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:155 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263592AbTL2Pyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 10:54:50 -0500
Date: Mon, 29 Dec 2003 16:54:41 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Frank van Maarseveen <frankvm@xs4all.nl>, Rob Love <rml@ximian.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 can run with HZ==0!
Message-ID: <20031229155441.GA31095@devserv.devel.redhat.com>
References: <20031228230522.GA1876@janus> <1072691126.5223.5.camel@laptop.fenrus.com> <20031229125240.GA4055@janus> <1072711585.4294.8.camel@fur> <20031229155433.GA4475@janus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20031229155433.GA4475@janus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2003 at 04:54:33PM +0100, Frank van Maarseveen wrote:
> I missed a two or three cases. Hoever, no sign of the tenfold size increase
> or any fixes inside SCSI ioctls or firewall rules (netfilter code I presume).

Robert's patchkit is quite incomplete too.

> Arjan, are you sure?

Yes.


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/8E5BxULwo51rQBIRAnXlAKCPmAvo3ykWjG6wKyg+Ohe2OYgwdACeJ4ZE
nN8bd5LaPKGSc0S5QV9MeRo=
=Me4j
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
