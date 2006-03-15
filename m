Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWCOOIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWCOOIF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 09:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCOOIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 09:08:05 -0500
Received: from lug-owl.de ([195.71.106.12]:19663 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751179AbWCOOIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 09:08:04 -0500
Date: Wed, 15 Mar 2006 15:08:00 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Lanslott Gish <lanslott.gish@gmail.com>
Cc: Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
Message-ID: <20060315140800.GC32065@lug-owl.de>
Mail-Followup-To: Lanslott Gish <lanslott.gish@gmail.com>,
	Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
	Greg KH <greg@kroah.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb <linux-usb-devel@lists.sourceforge.net>,
	tejohnson@yahoo.com, hc@mivu.no, vojtech@suse.cz
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com> <200603112155.38984.daniel.ritz-ml@swissonline.ch> <38c09b90603121701q69c61221lf92bb150e419b1c9@mail.gmail.com> <38c09b90603131710p7932c12qf6e8602b9b0b59c8@mail.gmail.com> <20060314103854.GC32065@lug-owl.de> <38c09b90603142030o7092a39aq8ace7758972ce09a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t8N2qprAjL+0GVly"
Content-Disposition: inline
In-Reply-To: <38c09b90603142030o7092a39aq8ace7758972ce09a@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--t8N2qprAjL+0GVly
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-15 12:30:04 +0800, Lanslott Gish <lanslott.gish@gmail.com> =
wrote:
> did you mean like that? thx.

That's basically the same patch as before?! What was ment is to move
inverting the axes into usbtouch_process_pkt().

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--t8N2qprAjL+0GVly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEGB/AHb1edYOZ4bsRAoLPAJ4o8fMnj28+16A3+NzTCovRugc/2gCbBzed
JheidQlwYaDGFqLY0CRbpqc=
=bLrX
-----END PGP SIGNATURE-----

--t8N2qprAjL+0GVly--
