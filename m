Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318098AbSGYAHQ>; Wed, 24 Jul 2002 20:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318105AbSGYAHQ>; Wed, 24 Jul 2002 20:07:16 -0400
Received: from durandal.simons-rock.edu ([64.210.108.44]:51427 "HELO
	durandal.simons-rock.edu") by vger.kernel.org with SMTP
	id <S318098AbSGYAHP>; Wed, 24 Jul 2002 20:07:15 -0400
Date: Wed, 24 Jul 2002 20:10:28 -0400 (EDT)
From: Marshal Newrock <marshal@simons-rock.edu>
To: linux-kernel@vger.kernel.org
Subject: HTP372 on K7RA-RAID / kernel 2.4.19rc3
Message-ID: <Pine.LNX.4.44.0207241953240.16813-100000@minerva.simons-rock.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HPT372 IDE RAID chip on an Abit K7RA-RAID
running a freshly installed Gentoo (has gcc-2.95)
kernel 2.4.19rc3, using devfs.
Western Digital 40GB ATA100 drive on /dev/hde, one partition, ext2
filesystem.

The system has no problem recognizing the HPT372, and can see the drive
and partitions.  I can generally mount it (mount /dev/hde1 /mnt), and 'ls
/mnt' lists the directories.  'ls -l /mnt' will give an 'input/output
error' for each directory.  Sometimes the ls or mount will hang, and I
have to kill the login from another shell.

Right now, I have the drive connected as /dev/hdc (replacing the CD
drives), and working fine.

I'm sure more info is needed, so tell me what you want me to do to help
troubleshoot this.  Please reply to me off-list as I am not subscribed.

Thanx.  :)

-- 
Marshal Newrock, Simon's Rock College of Bard
Caution: product may be hot after heating

