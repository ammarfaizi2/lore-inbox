Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268414AbTAMXYc>; Mon, 13 Jan 2003 18:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268415AbTAMXYb>; Mon, 13 Jan 2003 18:24:31 -0500
Received: from h80ad26f3.async.vt.edu ([128.173.38.243]:7808 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268414AbTAMXYa>; Mon, 13 Jan 2003 18:24:30 -0500
Message-Id: <200301132332.h0DNWQqZ001578@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*? 
In-Reply-To: Your message of "Mon, 13 Jan 2003 17:49:12 EST."
             <Pine.LNX.4.44.0301131748010.2102-100000@montezuma.mastecende.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0301131748010.2102-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_432919416P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jan 2003 18:32:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_432919416P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Jan 2003 17:49:12 EST, Zwane Mwaikambo said:
> On Mon, 13 Jan 2003, Jens Axboe wrote:
> 
> > > It uses NMI's to break into the debugger, so it would also work with 
> > > interrupts disabled and spinning on a lock, the same is also true for 
> > > kgdb.
> > 
> > But still requiring up-apic, or smp with apic, right?
> 
> Well UP with Local APIC will suffice. So that works on a lot of i686 
> machines.

This mean those of us that have a 'local_apic_kills_bios' flag in dmi_scan.c
are still out of luck, correct?

--==_Exmh_432919416P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+I0yJcC3lWbTT17ARAkuLAKCMmgvvwqVrW6PGpdPzRxmKTny5WwCgibVC
dGbkPl4SYjwnpAQLMf+iml0=
=wRFx
-----END PGP SIGNATURE-----

--==_Exmh_432919416P--
