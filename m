Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbSJUJss>; Mon, 21 Oct 2002 05:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbSJUJss>; Mon, 21 Oct 2002 05:48:48 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:23731 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261295AbSJUJsr>; Mon, 21 Oct 2002 05:48:47 -0400
Subject: Re: INTEL ICH4 / 845GL IDE support?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210141421.57263.roy@karlsbakk.net>
References: <200210141421.57263.roy@karlsbakk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 11:10:20 +0100
Message-Id: <1035195020.27318.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-14 at 13:21, Roy Sigurd Karlsbakk wrote:
> hi
> 
> Does 2.4 support the ICH4 chipset (as in Intel 845GL on an MSI MS-6526GL card) 
> with tuning/auto DMA etc?

Depends on the BIOS. 2.4.19 will for sane bioses, 2.4.20pre10 for bogon
ones

