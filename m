Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUFBOhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUFBOhf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUFBOhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:37:35 -0400
Received: from hostmaster.org ([212.186.110.32]:14976 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S263062AbUFBOh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:37:26 -0400
Subject: Re: Linux 2.6.7-rc2
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SJn9MXMDf1aFyPGrL0og"
Message-Id: <1086187044.6179.8.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 02 Jun 2004 16:37:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SJn9MXMDf1aFyPGrL0og
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

http://bugzilla.kernel.org/show_bug.cgi?id=3D2819

Make oldconfig silently disabled support for my CONFIG_TIGON3 NIC.

It seems that it depends on CONFIG_NET_GIGE which in turn depends on
CONFIG_NET_ETHERNET which was not required in 2.6.6 kernel.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Growing old is mandatory... growing up is optional.

--=-SJn9MXMDf1aFyPGrL0og
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUAQL3mJGD1OYqW/8uJAQK5JQgAhKFVot847begIiG2KUZaDaopw1X7wQ/G
+MxMZTBT2r7YL50cHbNKZZv0PLjno1vtGc3nOuiTfTGLIQ8Nz7xytCSqJvSzIOyl
eJCVg6dqDM9N+myY15aM2ZuOaUGp1gW8R1kiSWUioDQhjnX+QNWw76bPppRMm2nf
dFqZZ2sicE3saXxcx/ETnc5RAkk6AB+erLkrRdRtRNOi66tBp6VRLJmuA14bGYuR
w5PIxRHtw0Ps02VGlJtT7mmzZXSHPffVqPBpmRPjb0ewK25E4cROgjaDCwrZ04/I
jK3J5no1vaO1AJUYRXTJs8mPXRLyD1x1B9GpnclyVhR6aZALhBbJlA==
=9TpK
-----END PGP SIGNATURE-----

--=-SJn9MXMDf1aFyPGrL0og--

