Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270882AbTGNVks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270903AbTGNVkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:40:47 -0400
Received: from sea2-f60.sea2.hotmail.com ([207.68.165.60]:57871 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270882AbTGNVhI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:37:08 -0400
X-Originating-IP: [143.182.124.3]
X-Originating-Email: [dagriego@hotmail.com]
From: "David griego" <dagriego@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: alan@storlinksemi.com, linux-kernel@vger.kernel.org
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
Date: Mon, 14 Jul 2003 14:51:51 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F600qnqEBQdWfF00018804@hotmail.com>
X-OriginalArrivalTime: 14 Jul 2003 21:51:51.0681 (UTC) FILETIME=[22201F10:01C34A52]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > Layer one network processing is often handled by ASICS, also some of the
> > fastest encryption engines are hardware.  I suggest we don't wait until 
>your
> > proven wrong before making a decision on TOE.
>
>You don't have to. You can go build and test and maintain a set of TOE 
>patches.
>Nobody is stopping you. Lots of Linux code exists because someone decided 
>that
>the official story was wrong and proved it so.
>
Our team has done this twice aready for Linux (one TOE in software one as an 
ASIC).  It can be hard to make decisions on tradeoffs when the general 
consinsus in Linux is to not support TOE.  I'm sure that once everything is 
said and done we will provide a driver for our TOE to the community.  
Support from other OS venders has been better and feedback from them will 
defenitly influance our hardware design.
>
>Alan
>

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

