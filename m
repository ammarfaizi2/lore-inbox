Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161390AbWKER3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161390AbWKER3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 12:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWKER3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 12:29:22 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:1966 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161390AbWKER3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 12:29:21 -0500
Date: Sun, 5 Nov 2006 18:25:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur <caglar@pardus.org.tr>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Zachary Amsden <zach@vmware.com>, Gerd Hoffmann <kraxel@suse.de>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [Opps] Invalid opcode
In-Reply-To: <200611051917.56971.caglar@pardus.org.tr>
Message-ID: <Pine.LNX.4.61.0611051825060.15108@yvahk01.tjqt.qr>
References: <200611051507.37196.caglar@pardus.org.tr> <200611051740.47191.ak@suse.de>
 <200611051917.56971.caglar@pardus.org.tr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-810028756-1162747531=:15108"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-810028756-1162747531=:15108
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>05 Kas 2006 Paz 18:40 tarihinde, Andi Kleen şunları yazmıştı: 
>> How do you know this?
>
>Just guessing, if im not wrong panics occur after SMP alternative switching 
>code done its job.

Possibly compiled a kernel with instructions your processor does not 
support? Come to think of cmov...



	-`J'
-- 
--1283855629-810028756-1162747531=:15108--
