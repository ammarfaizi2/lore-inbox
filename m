Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbTJRQ2S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 12:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTJRQ2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 12:28:18 -0400
Received: from h80ad2667.async.vt.edu ([128.173.38.103]:29835 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261689AbTJRQ2O (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 12:28:14 -0400
Message-Id: <200310181624.h9IGOgLW023089@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: orinoco_cs module broken in test8 
In-Reply-To: Your message of "Sat, 18 Oct 2003 17:48:21 +0200."
             <yw1xoeweim2i.fsf@users.sourceforge.net> 
From: Valdis.Kletnieks@vt.edu
References: <200310181723.54967.aviram@beyondsecurity.com>
            <yw1xoeweim2i.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1866304097P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 18 Oct 2003 12:24:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1866304097P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Oct 2003 17:48:21 +0200, mru@users.sourceforge.net (=3D?iso-88=
59-1?q?M=3DE5ns_Rullg=3DE5rd?=3D)  said:
> Aviram Jenik <aviram@beyondsecurity.com> writes:
> =

> > Orinoco_cs worked for me in all previous 2.6.0-testx versions, but st=
opped =

> > working in test8. Message log shows:
> > kernel: orinoco_cs: RequestIRQ: Unsupported mode
> =

> You have to enable ISA bus support, i.e. CONFIG_ISA=3Dy.

If it worked for him in earlier -testX, he must have had it set before...=


Aviram:  Is CONFIG_ISA=3Dy in your -test8 .config?  If so, it's some othe=
r *new*
problem. If not, do you have any idea how it got turned off ('make oldcon=
fig'
weirdness??)


--==_Exmh_-1866304097P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/kWlJcC3lWbTT17ARAt4YAJ4gk2+wA8AGJEJ/FI6X1IuqqhKJdQCgyaLG
9x+g6SC0fWwzhl7s5Ee3wDA=
=TnRz
-----END PGP SIGNATURE-----

--==_Exmh_-1866304097P--
