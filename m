Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTIUNSb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 09:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbTIUNSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 09:18:31 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:2494 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262400AbTIUNSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 09:18:30 -0400
Subject: Re: 2.4.2[12] v VIA Rhine and VIA82x audio (working with a fight)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan Maciej <stephanm@muc.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309211505.17352.stephanm@muc.de>
References: <20030920163835.GA723@gallifrey>
	 <20030920200922.GC8953@mail.jlokier.co.uk>
	 <1064096092.23121.1.camel@dhcp23.swansea.linux.org.uk>
	 <200309211505.17352.stephanm@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064150215.3806.6.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Sun, 21 Sep 2003 14:16:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-21 at 14:05, Stephan Maciej wrote:
> > CMPCI in everything pre 2.4.22pre10-ac or so is obsolete and has all
> > sorts of problems with the later chips. C Tien of Cmedia sent a lot of
> > updates to the driver that were merged at that point.  
> 
> Are these in 2.4.23-pre4?

Unsure

> I have suspected this as being the reason for the lockups:

Already fixed in the newer cmpci driver

