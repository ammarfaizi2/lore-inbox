Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265841AbUFIQ44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUFIQ44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265852AbUFIQ4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:56:34 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:18048 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265851AbUFIQ4K (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 12:56:10 -0400
Message-Id: <200406091656.i59GuDeH019833@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6 
In-Reply-To: Your message of "Wed, 09 Jun 2004 10:17:04 +0200."
             <xb765a1uovz.fsf@savona.informatik.uni-freiburg.de> 
From: Valdis.Kletnieks@vt.edu
References: <xb7oenxyqly.fsf@savona.informatik.uni-freiburg.de> <200406071551.i57Fpl89023562@turing-police.cc.vt.edu> <xb7zn7fwdia.fsf@savona.informatik.uni-freiburg.de> <200406071636.i57Gafh7024942@turing-police.cc.vt.edu> <xb7r7sqwncc.fsf@savona.informatik.uni-freiburg.de> <200406081502.i58F2gF3013622@turing-police.cc.vt.edu>
            <xb765a1uovz.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_692204833P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Jun 2004 12:56:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_692204833P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Jun 2004 10:17:04 +0200, Sau Dan Lee said:

> Explain to me how a kernel compiled with
>         CONFIG_SERIO=3Dm
>         CONFIG_KEYBOARD_ATKBD=3Dm
> would be able to boot with "init=3D/bin/sh" and still have the keyboard=

> working.

Explain to me why you think that example is a good reason why
a kernel compiled with

CONFIG_SERIO=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy

should *NOT* be able to boot with 'init=3D/bin/sh'.

--==_Exmh_692204833P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAx0EtcC3lWbTT17ARAu8dAJ9LR3wXi33kuMKfhvSE7fgDNlsyIgCeOXP2
SIoGEKs2TpWGxPSrWt1LT+w=
=Qe7g
-----END PGP SIGNATURE-----

--==_Exmh_692204833P--
