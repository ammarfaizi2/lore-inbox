Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbSKVACP>; Thu, 21 Nov 2002 19:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267235AbSKVACO>; Thu, 21 Nov 2002 19:02:14 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:17291 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267233AbSKVACN>; Thu, 21 Nov 2002 19:02:13 -0500
Subject: Re: 2.4.20-rc2-xfs lockups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Eldridge <diz@cafes.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021121172619.B13450@ornery.cafes.net>
References: <20021121153122.B13338@ornery.cafes.net> 
	<20021121172619.B13450@ornery.cafes.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Nov 2002 00:38:25 +0000
Message-Id: <1037925505.9160.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-21 at 23:26, Mike Eldridge wrote:
> On Thu, Nov 21, 2002 at 03:31:22PM -0600, Mike Eldridge wrote:
> > all,
> > 
> > i recently replaced a pII-350 with a pair of pIII-500s in a tyan
> > S1836-DLUAN-GX board (440GX dual slot 1).  i'm now getting loads of NMI
> > interrupts for unknown reasons (reasons 2c and 3c).
> 
> after more googling, i've found several pieces of information that seem
> to suggest interrupt routing on 440GX-based motherboards is busted.
> 
> can anyone confirm this?  will booting with 'noapic' fix this problem?
> am i doomed to run a UP kernel?

It varies. Unfortunately Intel won't tell us how to sort this mess out. 

Alan

