Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTANGzw>; Tue, 14 Jan 2003 01:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbTANGzw>; Tue, 14 Jan 2003 01:55:52 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:12548 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S261660AbTANGzv>; Tue, 14 Jan 2003 01:55:51 -0500
Date: Tue, 14 Jan 2003 02:04:21 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5] new modules and initrd - when? Or perhaps how?
Message-ID: <Pine.LNX.4.44.0301140159180.24732-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The modules support (up to 0.9.8) doesn't seem to include mkinitrd, nor 
does the stock mkinitrd (at least the Redhat version) seem to like new 
modules. And if an initrd filesystem is built by hand it doesn't seem to 
load, fails with a can't find module type message. Yes, I had the correct 
new static loader in the initrd file.

Is it intended that this will work at some time, or am I missing a 
mkinitrd program or the incantation to create the filesystem by hand?
-- 
bill davidsen

