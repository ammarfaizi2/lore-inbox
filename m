Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbSJEFHF>; Sat, 5 Oct 2002 01:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262049AbSJEFHF>; Sat, 5 Oct 2002 01:07:05 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:63495 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S262046AbSJEFHE>; Sat, 5 Oct 2002 01:07:04 -0400
Date: Sat, 5 Oct 2002 00:12:28 -0500 (CDT)
From: "Milton D. Miller II" <miltonm@realtime.net>
Message-Id: <200210050512.g955CSx86532@sullivan.realtime.net>
To: viro@math.psu.edu
Subject: initramfs work
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Al,
  Is there somewhere one could see what you are planning to merge?  

I was following the klibc dicussion list, but the archiver went slient after
August.

I like the idea in general, but I wasn't sure where this was going.   It
looked like the discussion there was going for replacing the do_mounts with
the kernel uncpio/uncompress followed by a bunch of small utilities and
scripts.  I had some other ideas that I played with, but depend on starting
with a single binary to make a lot of sense (going for the multi-call binary
base approach).   (This would leave the initrd file for the user space).

If there is some place to get a preview I would appreciate it.

Thanks,
milton
