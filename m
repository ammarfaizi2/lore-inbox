Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318623AbSHGSNC>; Wed, 7 Aug 2002 14:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318750AbSHGSNC>; Wed, 7 Aug 2002 14:13:02 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:54523 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318623AbSHGSNB>; Wed, 7 Aug 2002 14:13:01 -0400
Subject: Re: Oopses on dual Athlon with 2.4.19-ac4 and 2.4.20-pre1-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020807180503.GI23816@os.inf.tu-dresden.de>
References: <20020807162932.GH23816@os.inf.tu-dresden.de>
	<1028746623.18156.328.camel@irongate.swansea.linux.org.uk> 
	<20020807180503.GI23816@os.inf.tu-dresden.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 20:35:42 +0100
Message-Id: <1028748942.18478.330.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 19:05, Adam Lackorzynski wrote:
> On Wed Aug 07, 2002 at 19:57:03 +0100, Alan Cox wrote:
> > On Wed, 2002-08-07 at 17:29, Adam Lackorzynski wrote:
> > > I have a dual Athlon here which ooopses after 2 minutes of dnetc when
> > > running 2.4.19-ac4 or 2.4.20-pre1-ac1. I cannot reproduce this with
> > > 2.4.19 or 2.4.20-pre1. The two Athlons are sitting on a A7M266-D.
> > 
> > Are you loading the amd76x_pm module for power management ?
> 
> No, the module wasn't loaded in any of the cases. Only ipv6 and rtc are
> loaded.

Can you reproduce it with ACPI disabled ?

