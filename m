Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVJVAgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVJVAgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 20:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVJVAgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 20:36:17 -0400
Received: from xenotime.net ([66.160.160.81]:33175 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751276AbVJVAgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 20:36:16 -0400
Date: Fri, 21 Oct 2005 17:36:12 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: James Hansen <linux-kernel-list@f0rmula.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Information on ioctl32
Message-Id: <20051021173612.06f1dadd.rdunlap@xenotime.net>
In-Reply-To: <4358CF73.3020602@f0rmula.com>
References: <4358CF73.3020602@f0rmula.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2005 12:22:27 +0100 James Hansen wrote:

> Hi,
> 
> I've been working my way through what I think is probably the seminal 
> work on the topic of device drivers, but it pre-dates ioctl32 and other 
> 32 compatibility stuff.
> 
> (The O'Reilly linux device driver book)  
> http://www.xml.com/ldd/chapter/book/ch03.html

That's LDD v2.

LDD v3 is here:
  http://lwn.net/Kernel/LDD3/

I don't see ioctl32 here, but lwn.net also has driver-porting info at:
  http://lwn.net/Articles/driver-porting/

> Is there anywhere that I can find some more information on this, such as 
> a howto?  I've been googling but have only really stumbled across some 
> brief info on lwn.net.


---
~Randy
