Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270120AbTGPErU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 00:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270121AbTGPErU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 00:47:20 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:26590 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S270120AbTGPErT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 00:47:19 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: usb in 2.4.22-pre6?
Date: Wed, 16 Jul 2003 01:02:07 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307160102.07774.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.62.27] at Wed, 16 Jul 2003 00:02:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greets everybody;

I have a camera, a Logitech(Sunplus ccd chipset) ClickSmart 310, usb 
interface, that almost works with qcam-vc.  But I just noticed, after 
rebooting to 2.4.22-pre6 earlier today, that the display on the 
camera no longer is reporting 'PC', and that there are some messages 
that look like problems in dmesg.

So my conclusion is that whatever has been adjusted in the usb stuffs, 
has now rendered the camera totally un-reachable.

This would make life difficult as I'm currently in negotiations with 
the Sunplus folks on the left coast trying to get a data sheet on the 
chipset in it so that I might try to write a new driver for these.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

