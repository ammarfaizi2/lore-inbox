Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318885AbSHEVEK>; Mon, 5 Aug 2002 17:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318881AbSHEVEF>; Mon, 5 Aug 2002 17:04:05 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:49396 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318839AbSHEVEB>; Mon, 5 Aug 2002 17:04:01 -0400
Subject: Re: Heavy Clock-Drift after update from Kernel 2.4.9 to 2.4.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208052251170.21076-100000@korben.citd.de>
References: <Pine.LNX.4.44.0208052251170.21076-100000@korben.citd.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 23:26:23 +0100
Message-Id: <1028586383.18478.100.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 22:03, Matthias Schniedermeyer wrote:

> A bit strange is that it seems to depend on load. Higher load seems to
> cause less/none clock drift.
> (e.g. when i compile something in background, the "rotating thing" in
> mozilla doesn't spin to fast)
> 
> Hardware is a Dual-PIII-933Mhz. Kernel is configured as SMP.
> Any more details needed?

Can you grab /proc/interrupts every 5 minutes for an hour and send me
the resulting file ?

