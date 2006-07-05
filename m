Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWGECrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWGECrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 22:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWGECrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 22:47:31 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:32407 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932299AbWGECra (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 22:47:30 -0400
Message-Id: <200607050247.k652lSG9006565@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext4 features
In-Reply-To: Your message of "Tue, 04 Jul 2006 22:40:05 EDT."
             <44AB2685.1000409@tmr.com>
From: Valdis.Kletnieks@vt.edu
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <44A98D5A.5030508@tmr.com> <200607032150.k63LoM4H027543@turing-police.cc.vt.edu> <44A9A196.1010602@tmr.com> <200607041501.k64F1qur024266@turing-police.cc.vt.edu>
            <44AB2685.1000409@tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152067647_2945P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Jul 2006 22:47:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152067647_2945P
Content-Type: text/plain; charset=us-ascii

On Tue, 04 Jul 2006 22:40:05 EDT, Bill Davidsen said:
> Valdis.Kletnieks@vt.edu wrote:
> >catching unintended config changes - I started using tripwire after I
> >fat-fingered a script, and the machine backed up to /dev/null instead of
> >/dev/rmt0.
> But it ran faster, right? ;-)

Yeah.  The tape ops figured I must have optimized something or gotten it
to do better incrementals - it would ask for the tape, and spit it out in
15 minutes instead of the 40-45 it used to take.  So it went un-noticed till
a full cycle of tapes had gone by...

Guess who was totally mystified when we lost a disk, we restored from tape,
and the system had time warped itself back 2 months? :)

--==_Exmh_1152067647_2945P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEqyg/cC3lWbTT17ARAnHgAJ4/83Fz6AWcn1unWual/npLSwsXdwCg9Bck
cNaq10i0KdZTPgwxOvVtf2s=
=0Ols
-----END PGP SIGNATURE-----

--==_Exmh_1152067647_2945P--
