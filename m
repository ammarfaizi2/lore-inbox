Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270970AbTGPQ6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270964AbTGPQ5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:57:05 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10368 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270957AbTGPQ4H (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:56:07 -0400
Message-Id: <200307161710.h6GHAsU1001493@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jens Axboe <axboe@suse.de>
Cc: Dave Jones <davej@codemonkey.org.uk>, vojtech@suse.cz,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session. 
In-Reply-To: Your message of "Wed, 16 Jul 2003 19:03:52 +0200."
             <20030716170352.GJ833@suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <20030716165701.GA21896@suse.de>
            <20030716170352.GJ833@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1548284510P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Jul 2003 13:10:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1548284510P
Content-Type: text/plain; charset=us-ascii

On Wed, 16 Jul 2003 19:03:52 +0200, Jens Axboe <axboe@suse.de>  said:

> Yes. You can try and make the situation a little better by unmasking
> interrupts with -u1. Or you can try and use a ripper that actually uses
> SG_IO, that way you can use dma (and zero copy) for the rips. That will
> be lots more smooth.

Dumb user question - which rippers support SG_IO?  I've been using cdparanoia
mostly for lack of a good reason to migrate - but this sounds like a good reason. ;)

--==_Exmh_1548284510P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/FYcecC3lWbTT17ARAp/AAKCovNmvEw+w1TB8AIncUanHU5bTRQCeO+v8
RA7Wnuxe5pC4MhV0/CPn500=
=dau6
-----END PGP SIGNATURE-----

--==_Exmh_1548284510P--
