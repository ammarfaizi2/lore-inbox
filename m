Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265461AbUBPIlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 03:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265466AbUBPIlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 03:41:04 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:24221 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265461AbUBPIlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 03:41:02 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Bill Anderson <banderson@hp.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: system (not HW) clock advancing really fast
Date: Mon, 16 Feb 2004 16:50:40 +0800
User-Agent: KMail/1.5.4
References: <1076910368.25980.12.camel@perseus> <1076917697.25980.35.camel@perseus> <200402161641.33323.mhf@linuxmail.org>
In-Reply-To: <200402161641.33323.mhf@linuxmail.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402161650.41016.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 February 2004 16:41, Michael Frank wrote:
> 
> a) Timer broken - too fast.
> b) Generates IRQ's on both edges
> c) the clock interrupt being routed into both CPU's 
>    at the same time. 

Actually, I think the Crystal oscillator is nuts,
explaing that it sometimes jumps by several seconds.

Could you get hold of some freezing spray find the Crystal... ;)

And, lets keep further mail of LKML - enough traffic there.

> 
> You could boot with NOSMP to rule out c)
> 
> Weird breakdown anyway,
> 
> Regards
> Michael
> 


