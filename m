Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318313AbSHZUaG>; Mon, 26 Aug 2002 16:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318310AbSHZUaF>; Mon, 26 Aug 2002 16:30:05 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:18670 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318313AbSHZUaE>; Mon, 26 Aug 2002 16:30:04 -0400
Subject: Re: [PATCH] hyperthreading scheduler improvement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1030393512.15007.435.camel@phantasy>
References: <1030392337.15007.413.camel@phantasy> 
	<1030392908.2776.17.camel@irongate.swansea.linux.org.uk> 
	<1030393512.15007.435.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 21:35:29 +0100
Message-Id: <1030394129.2776.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 21:25, Robert Love wrote:
> Do you think it could be some odd behavior on non-P4 x86 SMP systems? 
> Maybe sparse CPU ids?
> 
> At least for now, this 2.5 patch is P4-only.


It crashes on P4 systems

