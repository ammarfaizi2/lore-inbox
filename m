Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTJ0Deb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 22:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTJ0Deb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 22:34:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:63977 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263388AbTJ0Dea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 22:34:30 -0500
Date: Sun, 26 Oct 2003 19:32:40 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: dveatch@woh.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Menuconfig encountered an error (follow up)
Message-Id: <20031026193240.52ef4249.rddunlap@osdl.org>
In-Reply-To: <200310262215.34921.dveatch@woh.rr.com>
References: <200310262215.34921.dveatch@woh.rr.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Oct 2003 22:15:34 -0500 Dennis Veatch <dveatch@woh.rr.com> wrote:

| Mandrake 9.2, kernel source 2.4.22-18mdk
| 
| The error;
| 
| Menuconfig has encountered a possible error in one of the kernel's 
| configuration files and is unable to continue. Here is the error report;
| 
| Q> scripts/Menuconfig: line832: MCmenu78: command not found
| 
| 
| I do not remember what part of the menu I was in when this happened.
| 
| It happens when I try to enter Alsa Sound.

Based on very similar previous emails on the same subject
(which should be findable via a mail archive search),
this is a Mandrake-induced problem.  This problem does not
happen in a kernel from www.xz.kernel.org.
Please contact Mandrake for a fix.

--
~Randy
