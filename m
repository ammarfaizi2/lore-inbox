Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbUBZS7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUBZS7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:59:19 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:40196 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262885AbUBZS7J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:59:09 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] WOLK v1.0 for Kernel v2.6.3
Date: Thu, 26 Feb 2004 19:24:37 +0100
User-Agent: KMail/1.6.1
Cc: wolk-devel@lists.sourceforge.net, wolk-announce@lists.sourceforge.net
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Working Overloaded Linux Kernel
Message-Id: <200402260248.52516@WOLK>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

first WOLK version for 2.6. Apply ontop of a vanilla 2.6.3 from kernel.org.

Tell me what you think, how it works, what I've missed, what should go in bla
bla you know what I mean ;)

Have fun :)



Changelog from v2.6.3 -> v2.6.3-wolk1.0
- ---------------------------------------
o   added:    2.6.3-mm4 except 4g/4g stuff (it breaks PaX)	(Andrew Morton)
o   added:    PaX 2.6.3-200402250000				(PaX Team)
o   added:    autoregulate swappiness				(Con Colivas)
o   added:    extend memstats					(me)
o   added:    dmesg cleanup					(dunno?)
o   added:    Application Layer 7 Packet Classifier v0.4.1b	(Ethan Sommer)
o   added:    Bootsplash v3.1.3					(SuSE GmbH)
o   added:    SuperMount-NG v2.0.4				(Andrey Borzenkov)
o   added:    ReiserFS v4 snapshot 2004.02.25			(Namesys)
o   added:    Prism GT/Duette 802.11(a/b/g) PCI/PCMCIA support	(Luis Rodriguz)
o   added:    HostAP driver v0.1.3				(Jouni Malinen)
o   added:    SquashFS v1.3-r3					(Phillip Lougher)
o   added:    Speakup accessibility				(Speakup Guys)
o   added:    Linux InfraRed Controller v2.6.3-20040224		(LIRC Guys)
o   added:    Broadcom BCM5700 driver v7.1.22			(Broadcom Corporation)
o   added:    UCL nrv2e compression algorithm v2.6-20040217	(Luca Barbato)
o   added:    initrd support for cramfs				(Herbert Xu)
o   added:    HP OmniBook support				(Soós Péter)
o   added:    CONFIG_HZ						(Mikael Pettersson)
o   added:    IBM Power Linux RAID adapter support v2.0		(IBM Corporation)
o   added:    SCSI Media Changer v0.22				(Gerd Knorr)
o   added:    Twofish encryption for loop device		(SuSE GmbH)
o   added:    ReiserFS extended attributes			(SuSE GmbH)
o   added:    ReiserFS POSIX Access Control Lists		(SuSE GmbH)
o   added:    ReiserFS Security Labels				(SuSE GmbH)
o   added:    Scheduler Tweaks preselections			(me)
o   fixed:    disabled Macintosh device drivers for all but PPC	(me)
o   fixed:    enable adaptec SCSI RAID adapters			(Adaptec)
o   fixed:    prevent amd64 laptops from hanging when		(?)
                unplugging power cord, or closing lid.



Todo
- ----
o  grsecurity once it's out for 2.6 (Brad, move your ass ;)
o  menu cleanups


md5sums:
- --------
ba475315c783d473a4c1e26f2b0a2039 *linux-2.6.3-wolk1.0.patch.bz2
72da973aac989c6c980364a5f4800511 *linux-2.6.3-wolk1.0.patch.gz



- --
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint:  3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at http://pgp.mit.edu. Encrypted e-mail preferred
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPjnlVp3i49tEGhYRAvViAJwMYRX8SCCaJCKZIJWSAWpxxoMa2ACg7t2M
A9ywObt4uwJ4PYPAnkzjHpo=
=Hoh/
-----END PGP SIGNATURE-----
