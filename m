Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269334AbTHOQfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbTHOQNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:13:01 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269334AbTHOQJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:31 -0400
Date: Fri, 15 Aug 2003 10:23:38 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: linux-kernel@vger.kernel.org
Subject: Clean Slackware 9.0 Install And...
Message-ID: <Pine.LNX.4.56.0308151023080.28412@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm out of clues as to what is causing these kernel problems/oopses?

Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c0110036
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0110036>]    Not tainted
EFLAGS: 00210202
eax: 00008602   ebx: f05e0403   ecx: f05e0004   edx: 00000000
esi: 000051c0   edi: c02ff230   ebp: f05ebf1c   esp: e7d9bf38
ds: 0018   es: 0018   ss: 0018
Process galeon (pid: 11488, stackpage=e7d9b000)
Stack: f05ea000 e7d9a000 f1862730 e7d9bf6c ee6c51c0 e24b6000 ee6c51c0
e7d9a000
       00000000 c035ea00 0007f00c e7d9bf78 055d3ec7 e7d9bfa0 c0114ef2
e7d9bf78
       00000000 00000000 0007f00c e7d9a000 c0114e50 e7d9bfac 00000000
bf3ff7ec
Call Trace:    [<c0114ef2>] [<c0114e50>] [<c0120262>] [<c0108f13>]

Code: 88 1a 5b 5e 0f b6 c4 5f c3 90 55 57 56 53 53 8b 54 24 1c 8b

