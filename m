Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbTCMAsz>; Wed, 12 Mar 2003 19:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261693AbTCMAsy>; Wed, 12 Mar 2003 19:48:54 -0500
Received: from WARSL401PIP7.highway.telekom.at ([195.3.96.94]:56675 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S261485AbTCMAsx>;
	Wed, 12 Mar 2003 19:48:53 -0500
Date: Thu, 13 Mar 2003 02:00:56 +0100 (CET)
From: Clifford Wolf <clifford@clifford.at>
X-X-Sender: clifford@localhost
To: linux-kernel@vger.kernel.org
Subject: OT: MDLBL - Multi-Disk-Linux-Boot-Loader v0.1
Message-ID: <Pine.LNX.4.44.0303130159580.10585-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just FYI: I've create a template disk image + small shell script for
creating a multi-disk linux boot floppies for kernels and/or initrd's
with a size > 1.44 MB. It's based on FreeDOS Beta 8, the XMSdsk ramdisk
and Loadlin:

	http://www.rocklinux.org/people/clifford/MDLBL/

I primary wrote it for ROCK Linux <www.rocklinux.org> but it might be
usefull for everyone who wants to boot larger (2.5) kernels from floppies.

yours,
 - clifford

PS: Linux-Kernel and FreeDOS-Dev List members: I'm not subscribed to the
list, so please CC me if you reply to this mail..

-- 
| Clifford Wolf ............ www.clifford.at . . . IRC: www.freenode.net
| ROCK Linux Workgroup ..... www.rocklinux.org . . Tel: +43-699-10063494
| NTx Consulting Group ..... www.ntx.at  . . . . . Fax: +43-2235-42788-4
| Vocat.cc ................. www.vocat.cc  . . . . . . . . . . . . . . .
| EDEN Creations ........... www.edenevents.at . . . . . . . . . . . . .
+------=[ Usenet Compliant Signature (RFC 2646) ]=---> www.rocklinux.net

>>>  I'm looking for a new job:  http://www.clifford.at/resume.html  <<<

Reality corrupted. Reboot universe? (Y/N)              /"\  ASCII Ribbon
                                                       \ /  Campaign
There are only 10 types of people in the world:         X   Against
Those who understand binary and those who don't.       / \  HTML Mail


