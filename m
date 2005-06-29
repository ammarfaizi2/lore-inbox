Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVF2TIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVF2TIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 15:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVF2TIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 15:08:31 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:31913 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262402AbVF2TIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 15:08:21 -0400
Message-Id: <200506291905.j5TJ5FIs025472@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: mjt@nysv.org (Markus =?UNKNOWN?Q?T=F6rnqvist?=)
Cc: Douglas McNaught <doug@mcnaught.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Your message of "Wed, 29 Jun 2005 16:58:20 +0300."
             <20050629135820.GJ11013@nysv.org> 
From: Valdis.Kletnieks@vt.edu
References: <200506290509.j5T595I6010576@laptop11.inf.utfsm.cl> <m2k6kd2rx8.fsf@Douglas-McNaughts-Powerbook.local>
            <20050629135820.GJ11013@nysv.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1120071898_16560P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Jun 2005 15:05:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1120071898_16560P
Content-Type: text/plain; charset=us-ascii

On Wed, 29 Jun 2005 16:58:20 +0300, Markus =?UNKNOWN?Q?T=F6rnqvist?= said:
> What pisses me off is the fact that Gnome and friends implement
> their own incompatible-with-others VFS's and automounters and
> stuff.

The fact that things like Gnome, which are basically consumers of their own
dogfood, have incompatible versions says very loudly that there's no consensus
on the semantics....

> Surely supporting this in the kernel and extending the LSB
> to require this is the best step to take without infringing
> anyone's freedom as such.

First we need to decide *if* it's to be supported, then *what* to support....

--==_Exmh_1120071898_16560P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCwvDYcC3lWbTT17ARAhqcAKDYVA4BOqtoZtCRjutERb4BRbuIRACgj6lK
wrsUkBCxbDzoH4Vo7CfLtm8=
=wVqz
-----END PGP SIGNATURE-----

--==_Exmh_1120071898_16560P--
