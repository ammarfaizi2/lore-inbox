Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSCKVZj>; Mon, 11 Mar 2002 16:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292533AbSCKVZ2>; Mon, 11 Mar 2002 16:25:28 -0500
Received: from cpe-66-87-67-85.ca.sprintbbd.net ([66.87.67.85]:16132 "EHLO
	minerva.ekline.com") by vger.kernel.org with ESMTP
	id <S290797AbSCKVZU>; Mon, 11 Mar 2002 16:25:20 -0500
Message-Id: <200203112124.g2BLOFP01544@minerva.ekline.com>
Content-Type: text/plain; charset=US-ASCII
From: Erik Kline <ekline@ekline.com>
To: linux-kernel@vger.kernel.org
Subject: [module/patch] optional /proc/patches ??
Date: Mon, 11 Mar 2002 13:24:15 -0800
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I was wondering whether something like a /proc/patches might be useful. This 
could help list patches applied to a kernel such that "uname -a" and "cat 
/proc/patches" provides some good information about the kernel, especially 
stock kernels from distributions. I was able to work up a quick module 
available at the link below. NOTE: I couldn't solve how to add entries fo a 
patchlist structure using regular context diffs, but ed diffs work just 
great. More information in the README attached. I'd very much appreciate any 
feedback on whether this is useful and how it should actually be implemented, 
if at all. Please note that my only access to lkml traffic is via Kernel 
Traffic so I would appreciate being Cc'ed.

Thanks all,

-Erik (humble linux aficionado)

[patchlist module]
http://ekline.com/linux/patchlist-0.0.1.tar.gz
