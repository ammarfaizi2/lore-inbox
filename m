Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270624AbTGNNv2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270434AbTGNNsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:48:16 -0400
Received: from web60004.mail.yahoo.com ([216.109.116.227]:58960 "HELO
	web60004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270624AbTGNNqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:46:38 -0400
Message-ID: <20030714140127.4336.qmail@web60004.mail.yahoo.com>
Date: Mon, 14 Jul 2003 15:01:27 +0100 (BST)
From: =?iso-8859-1?q?Mike=20Martin?= <redtuxxx@yahoo.co.uk>
Subject: Kernel oops with 2.5.74 2.5.75
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting a kernel oops with both these kernels as soon as it the
kernel loads the ide drivers (hd*)

I am using ALI1542 chipset, K6/2 500 cpu
I have tried progressively disabling various ide options (cramfs,
acls tcq etc) to no effect

I run ext3 compiled in

This is on a base of RH9 with updated modutils from rawhide.

The kernel apparrently compiles fine (no errors)

Anyone any ideas what could be the cause of this (2.5.66 worked on
this machine and runs 2.4.21 fine)

If its not a simple fix I will bugzilla it

__________________________________________________
Yahoo! Plus - For a better Internet experience
http://uk.promotions.yahoo.com/yplus/yoffer.html
