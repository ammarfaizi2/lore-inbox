Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312361AbSDEIEK>; Fri, 5 Apr 2002 03:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312364AbSDEIEA>; Fri, 5 Apr 2002 03:04:00 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:29902 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S312361AbSDEIDs>; Fri, 5 Apr 2002 03:03:48 -0500
Date: Fri, 5 Apr 2002 10:03:47 +0200 (CEST)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Q] reiserfs error message at boot-time
Message-ID: <Pine.LNX.4.40.0204050959290.13705-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

i just moved my linux partitition from ext3 to reiserfs.
now my problem:

when i boot, i get this error-message:
reiserfs: Unrecognized mount option errors
reiserfs: Unrecognized mount option errors

i get this message also at shutdown ... and on the next boot, reiserfs
replays the logfile ...

reiserfs: checking transaction log (device 03:02) ...
Warning, log replay starting on readonly filesystem

in /etc/fstab i mount the filesystem with "defaults" ...

where is the problem ?
what do i do wrong ?
hope someone can give me a hint ...

daniel

# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

