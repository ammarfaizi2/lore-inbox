Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbTBJTyv>; Mon, 10 Feb 2003 14:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTBJTyv>; Mon, 10 Feb 2003 14:54:51 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:32018 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S262808AbTBJTyu>; Mon, 10 Feb 2003 14:54:50 -0500
Date: Mon, 10 Feb 2003 14:04:34 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: Is -fno-strict-aliasing still needed?
Message-ID: <20030210200434.GA376@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I ask because I've just built a kernel without using that flag -
linus-2.5 BK from this morning, probably missing the 2.5.60 release by
a few hours. I'm now running with the kernel, and things are working
normally. So, my success with my strictly aliased kernel has made me curious
if the continuing use of the flag has outlived its usefulness. I'm
running on i586, compiling with gcc-3.2.2 (CVS). Possibly the flag is
needed for other chipsets or older compilers, or particular bits of code
that I don't compile. Still, I thought I'd ask and see. Maybe other
people can try building without '-fno-strict-aliasing' and see what sort
of results they get.

I'm not including my config file to save space, but can send it if
asked.

Art Haas
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
