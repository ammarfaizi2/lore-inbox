Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbUCLClb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 21:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUCLClb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 21:41:31 -0500
Received: from [12.177.129.25] ([12.177.129.25]:41667 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261921AbUCLCla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 21:41:30 -0500
Message-Id: <200403120313.i2C3DstV005296@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: uml-patch-2.6.4-1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Mar 2004 22:13:54 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates UML to 2.6.4.  Besides the update, there were the following
changes since the last patch:
	a bug which caused either a crash in the kernel or a BUG at exit.c:793
was fixed
	a bug which caused a crash when a process tried to dump core was fixed
	the hang early in boot on GHz hosts is gone
	various other

The 2.6.4-1 UML patch is available at
	http://www.user-mode-linux.org/mirror/uml-patch-2.6.4-1.bz2

BK users can pull my 2.5 repository from
	http://www.user-mode-linux.org:5000/uml-2.5

For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org

				Jeff


