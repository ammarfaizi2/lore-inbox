Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317363AbSINQLf>; Sat, 14 Sep 2002 12:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317366AbSINQLf>; Sat, 14 Sep 2002 12:11:35 -0400
Received: from p508377C6.dip.t-dialin.net ([80.131.119.198]:19720 "HELO
	486dx.ferdinand.de") by vger.kernel.org with SMTP
	id <S317363AbSINQLf>; Sat, 14 Sep 2002 12:11:35 -0400
From: "Dieter Ferdinand" <dieter.ferdinand@gmx.de>
To: linux-kernel@vger.kernel.org
Date: Sat, 14 Sep 2002 14:41:47 +1
MIME-Version: 1.0
Subject: PROBLEM: nfs mount hangs, program is dead an i can't umount or kill the program
Reply-To: Dieter.Ferdinand@gmx.de
Message-ID: <3D834AAB.14580.39F2BD5@localhost>
X-mailer: Pegasus Mail for Windows (v4.01, DE v4.01-R1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
i have big problem with my nfs-mounts.

sometimes, the nfs-mount is stalled an i can only reaktivate it, when i umount and 
mount it again.

when a program is accessing this mount, and i can't kill it,i  must reboot the pc.

the most time, i have this problem with this pc's:
the server is a p3-550 :
Linux linux-p3 2.2.20 #20 SMP Mon Apr 29 18:17:06 CEST 2002 i686 unknown

the client is a p2-350 dual-system:
Linux p2-350 2.4.18-SMP #1 SMP Sat Jul 20 01:52:33 CEST 2002 i686 unknown

i have the problem with stalled nfs-mounts also on a 486dx66:
Linux 486dx 2.2.19 #1 Sun Apr 21 10:39:32 CEST 2002 i486 unknown

the network have no problems, the problem comes from the nfs-connection.

when i only have a chance to kill the hanging processed and the stalled mount, i can 
reaktivate it, without reboot.
but the mount is busy by the hanging program and i can't kill the program, because 
the nfs is stalled and i can't umount the nfs, because it is busy by the program.

there is not posibility to break this ring, also i reboot the pc.

goodby
Schau auch einmal auf meine Homepage (http://go.to/dieter-ferdinand).
Dort findest du Information zu Linux, Novell, Win95, WinNT, ...

