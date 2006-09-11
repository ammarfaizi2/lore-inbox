Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWIKFya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWIKFya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWIKFya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:54:30 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:6788 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964893AbWIKFy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:54:28 -0400
Date: Mon, 11 Sep 2006 01:51:26 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Menuconfig won't draw lines on my terminal?
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Roman Zippel <zippel@linux-m68k.org>
Message-ID: <200609110152_MC3-1-CAD7-1E87@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using PuTTY as SSH client, I get ASCII chars instead of lines when
I use menuconfig:

 Linux Kernel v2.6.18-rc6 Configuration
 qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq
  lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq Linux Kernel Configuration qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk
  x  Arrow keys navigate the menu.  <Enter> selects submenus --->.  Highlighted letters are     x
  x  hotkeys.  Pressing <Y> includes, <N> excludes, <M> modularizes features.  Press <Esc><Esc> x
  x  to exit, <?> for Help, </> for Search.  Legend: [*] built-in  [ ] excluded  <M> module     x
  x  < > module capable                                                                         x
  x lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk x
  x x             Code maturity level options  --->                                           x x
  x x             General setup  --->                                                         x x
  x x             Loadable module support  --->                                               x x


This happens on both Fedora Core 2 and 5.  Midnight Commander draws lines,
so I know the characters are in the font.

-- 
Chuck

