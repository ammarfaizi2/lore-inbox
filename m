Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVEJLqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVEJLqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 07:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVEJLqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 07:46:44 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:10426 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261615AbVEJLql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 07:46:41 -0400
Date: Tue, 10 May 2005 13:46:19 +0200
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DocBook: only use tabular style for long synopsis
Message-ID: <20050510114619.GW3562@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050509203808.GT3562@admingilde.org> <20050509182825.0b2ac473.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qoynMflHD4PlumZh"
Content-Disposition: inline
In-Reply-To: <20050509182825.0b2ac473.akpm@osdl.org>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qoynMflHD4PlumZh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 09, 2005 at 06:28:25PM -0700, Andrew Morton wrote:
> Are you interested in becoming the official docbook person, send in a
> MAINTAINERS patch?

well I don't want to write all the documentation but I can maintain
the DocBook system.

---
 MAINTAINERS |    5 +++++
 1 files changed, 5 insertions(+)

Index: linux-docbook/MAINTAINERS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-docbook.orig/MAINTAINERS	2005-05-02 09:16:19.000000000 +0200
+++ linux-docbook/MAINTAINERS	2005-05-10 13:43:37.975532756 +0200
@@ -730,6 +730,11 @@ M:	tori@unhappy.mine.nu
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
=20
+DOCBOOK FOR DOCUMENTATION
+P:	Martin Waitz
+M:	tali@admingilde.org
+S:	Maintained
+
 DOUBLETALK DRIVER
 P:	James R. Van Zandt
 M:	jrv@vanzandt.mv.com

--=20
Martin Waitz

--qoynMflHD4PlumZh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCgJ8Lj/Eaxd/oD7IRAigpAJ9oEiZLRBqhVkM43UcxYD4P9W9vFgCdHnkF
+mtimCNUZCyAh9jwgazlOQk=
=+otM
-----END PGP SIGNATURE-----

--qoynMflHD4PlumZh--
