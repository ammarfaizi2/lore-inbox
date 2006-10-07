Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWJGLoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWJGLoL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 07:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWJGLoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 07:44:11 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:23457 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750962AbWJGLoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 07:44:10 -0400
Date: Sat, 7 Oct 2006 13:43:50 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: trash@kaber.net
Subject: Bytecounting broken?
Message-ID: <Pine.LNX.4.61.0610071341250.4481@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


the 'bytes' counter in iptables -L -v -n does not increase as fast as 
the one in iptraf. What is causing this? (There are no packets 
currently FORWARDed - it's all OUTPUT)

Linux ichi 2.6.18 #1 SMP Mon Sep 25 19:30:03 CEST 2006 i686 athlon i386 
GNU/Linux


	-`J'
-- 
