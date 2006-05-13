Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWEMIvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWEMIvR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 04:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWEMIvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 04:51:17 -0400
Received: from lug-owl.de ([195.71.106.12]:32388 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750752AbWEMIvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 04:51:16 -0400
Date: Sat, 13 May 2006 10:51:14 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/13: eCryptfs] fs/Makefile and fs/Kconfig
Message-ID: <20060513085114.GB23642@lug-owl.de>
Mail-Followup-To: Phillip Hellewell <phillip@hellewell.homeip.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk,
	mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
	toml@us.ibm.com, yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
References: <20060513033742.GA18598@hellewell.homeip.net> <20060513034051.GA18631@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <20060513034051.GA18631@hellewell.homeip.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-12 21:40:51 -0600, Phillip Hellewell <phillip@hellewell.hom=
eip.net> wrote:
> This is the 1st patch in a series of 13 constituting the kernel
> components of the eCryptfs cryptographic filesystem.
>=20
> This patch modifies the fs/Kconfig and fs/Makefile files to
> incorporate eCryptfs into the kernel build.

This should have been the last patch: if you're building with a random
config and only this patch applied (applying in order, of course), you
won't get a kernel image.

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

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEZZ4CHb1edYOZ4bsRAlIOAKCL8Z7Gjz8fbQqGlXEIE2Ck9Nh2IgCeLOtH
W96+o24jXllsE7RhjaXZ+7o=
=hwep
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
