Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbSJ3PII>; Wed, 30 Oct 2002 10:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbSJ3PII>; Wed, 30 Oct 2002 10:08:08 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1667 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264705AbSJ3PIG>; Wed, 30 Oct 2002 10:08:06 -0500
Subject: Re: Network Device Driver Help Required
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Harish Kulkarni <hari@cosystech.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <NFBBKDONILLOCGDCFLLICELCCFAA.hari@cosystech.com>
References: <NFBBKDONILLOCGDCFLLICELCCFAA.hari@cosystech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Oct 2002 15:32:39 +0000
Message-Id: <1035991959.5140.92.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-29 at 14:47, Harish Kulkarni wrote:
> 	e.g. in my case T1/E1 driver will interface with Lapd, i have found skbuffs
> utilization for
> 	doing the same. I am not clear on the same?. How skbuffs can be used. ( if
> possible please provide/suggest me with a piece of
> 	demo code which can be handy to understand "skbuffs" concepts.

See Documentation/networking/lapb-module, for the LAPB interface. 

>  Can i have any other interface for applications other then sockets?

Up to you. For WAN drivers there is a standardised set of interfaces


