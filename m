Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVASTxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVASTxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVASTxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:53:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2713 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261563AbVASTxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:53:14 -0500
Subject: Re: thoughts on kernel security issues
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: John Richard Moser <nigelenki@comcast.net>
Cc: Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41EEB920.8050609@comcast.net>
References: <20050112182838.2aa7eec2.akpm@osdl.org>
	 <20050113033542.GC1212@redhat.com>
	 <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
	 <20050113082320.GB18685@infradead.org>
	 <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
	 <1105635662.6031.35.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>
	 <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu>
	 <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu>
	 <41EEA86D.7020108@comcast.net>
	 <1106160943.6310.184.camel@laptopd505.fenrus.org>
	 <41EEB920.8050609@comcast.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c1Bf/ohfU+l+hWG4W/Z9"
Organization: Red Hat, Inc.
Date: Wed, 19 Jan 2005 20:53:10 +0100
Message-Id: <1106164390.6310.193.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c1Bf/ohfU+l+hWG4W/Z9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> >=20
> > Exec Shield does that too but only if your CPU has hardware assist for
> > NX (which all current AMD and most current intel cpus do).
> >=20
>=20
> Uh, ok.  You've read the code right?  *would rather hear from Ingo*

I co-developed a bunch of it together with Ingo in fact, and did lots
and lots of reviews on it as a whole and worked on it for over a year in
relation with putting it in the Fedora kernel etc etc.
So yes I have read the code.



--=-c1Bf/ohfU+l+hWG4W/Z9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB7rqlpv2rCoFn+CIRAuTKAJ0cbO6UFq+9s4UeQnraeFJnFQnvzwCfSI0H
hUl5b1UpF6pb2R70O1qN1M0=
=EUP4
-----END PGP SIGNATURE-----

--=-c1Bf/ohfU+l+hWG4W/Z9--

