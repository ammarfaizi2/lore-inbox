Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVBOVKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVBOVKB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 16:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVBOVKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 16:10:01 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13329 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261887AbVBOVJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 16:09:46 -0500
Message-Id: <200502152109.j1FL92HG023685@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lee Revell <rlrevell@joe-job.com>
Cc: Diego Calleja <diegocg@gmail.com>, prakashp@arcor.de,
       paolo.ciarrocchi@gmail.com, gregkh@suse.de, pmcfarland@downeast.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release 
In-Reply-To: Your message of "Tue, 15 Feb 2005 14:51:06 EST."
             <1108497066.7826.33.camel@krustophenia.net> 
From: Valdis.Kletnieks@vt.edu
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net> <20050211011609.GA27176@suse.de> <1108354011.25912.43.camel@krustophenia.net> <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de> <1108422240.28902.11.camel@krustophenia.net> <20050215004329.5b96b5a1.diegocg@gmail.com>
            <1108497066.7826.33.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1108501741_4257P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Feb 2005 16:09:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1108501741_4257P
Content-Type: text/plain; charset=us-ascii

On Tue, 15 Feb 2005 14:51:06 EST, Lee Revell said:

> I wonder if XP's solution is patented.

If it is, IBM's OS/360 and OS/VS1 and MVS had prior art way back in the 70's.
There were *plenty* of products that would look at the system call usage and
spit out an ordered load list for SYS1.LINKLIB and SYS1.LPALIB - so the idea of
machine-optimizing the list of things to cache for a fast startup is *not*
new.

I'd not be surprised to find out that somebody did something like that on the 7094 ;)


--==_Exmh_1108501741_4257P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCEmTtcC3lWbTT17ARAhDHAKDemp78nnSpKrXjFs0bqqrQj0U6SQCdGRT7
MCUa2ow+2uYNJBLYWvbZjJ0=
=leTS
-----END PGP SIGNATURE-----

--==_Exmh_1108501741_4257P--
