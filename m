Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266302AbUA2SyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 13:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUA2SyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 13:54:05 -0500
Received: from web41010.mail.yahoo.com ([66.218.93.9]:20405 "HELO
	web41010.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266302AbUA2SyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 13:54:03 -0500
Message-ID: <20040129185401.12454.qmail@web41010.mail.yahoo.com>
Date: Thu, 29 Jan 2004 10:54:01 -0800 (PST)
From: Satheesh Kumar <nksk76@yahoo.com>
Subject: Kernel compilation : make modules fails
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I installed a fresh RedHat 9.0 distribution on my
system. I'm trying to compile kernel with a new
driver. The compilation steps I'm following are as
below:
* make oldconfig
* make dep
* make bzImage
* make modules
* make modules_install

Till 'make bzImage' everything succeeds. However,
'make modules' fails.

Can someone help me out with this? Are there any known
problems and solutions wit RH9.0 distribution of the
kernel sources? The kernel version is 2.4.20.

Thanks in advance!!

-Satheesh

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/
