Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTH2PNs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 11:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTH2PNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 11:13:43 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10880 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261335AbTH2PNL (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 11:13:11 -0400
Message-Id: <200308291513.h7TFD8GG003209@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Nick Urbanik <nicku@vtc.edu.hk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Single P4, many IDE PCI cards == trouble?? 
In-Reply-To: Your message of "Fri, 29 Aug 2003 22:00:58 +0800."
             <3F4F5C9A.5BAA1542@vtc.edu.hk> 
From: Valdis.Kletnieks@vt.edu
References: <3F4EA30C.CEA49F2F@vtc.edu.hk> <1062150643.26753.4.camel@dhcp23.swansea.linux.org.uk>
            <3F4F5C9A.5BAA1542@vtc.edu.hk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_419877389P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Aug 2003 11:13:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_419877389P
Content-Type: text/plain; charset=us-ascii

On Fri, 29 Aug 2003 22:00:58 +0800, Nick Urbanik said:

> what motherboard, IDE cards you are using.  I used to imagine that a
> terabyte of RAID storage on one P4 machine with ordinary cheap IDE cards
> with software RAID would be feasible.  I believe it is not (although I
> cannot afford to play musical motherboards).
...
> I am giving up now, and have shelled out big dollars for a 3ware 7506-8,
> which I will install early next week once I've figured out how to back up
> and restore 203GB without shelling out even more money.

Exactly.  The *real* reason why a terabyte of RAID is expensive - if it's
important enough to RAID, it's important enough to back up (with the possible
exception of RAID striping for performance on a multi-hundred-gig scratch
space).

/Valdis (who once got to clean up 600M of mess after a busticated RAID
controller dropped its cache to the right blocks on the wrong disks :)

--==_Exmh_419877389P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/T22DcC3lWbTT17ARAk7cAKCe7aVAwKNdWHSs4GlVbPTaKiwiCACfeymT
QqviOEMICXSh4cu/P7MM7xE=
=j/xF
-----END PGP SIGNATURE-----

--==_Exmh_419877389P--
