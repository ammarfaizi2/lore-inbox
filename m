Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265323AbSKEXJO>; Tue, 5 Nov 2002 18:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265326AbSKEXJO>; Tue, 5 Nov 2002 18:09:14 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:28055 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265323AbSKEXJM>; Tue, 5 Nov 2002 18:09:12 -0500
Subject: Re: EVMS announcement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Corry <corryk@us.ibm.com>
Cc: evms-devel@lists.sourceforge.net, evms-announce@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <02110516191004.07074@boiler>
References: <02110516191004.07074@boiler>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 23:37:50 +0000
Message-Id: <1036539470.7386.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 22:19, Kevin Corry wrote:
> Looking ahead, we *will* continue to *fully* support the 1.2.0 version
> of EVMS on 2.4 kernels, and possibly release a 1.2.1 version with some
> recent bug fixes. We will also make a reasonable effort to maintain the

I plan to try and push LVM2 to Marcelo after the next release. Whether
he will take it I don't know. Obviously its good to have the ability to
move back nicely to older kernels.

> In summary, we feel that this decision is the best way to support our
> users for the long term. We want to provide EVMS on current and future

Throwing away a big piece of code really sucks. I think however its the
right path - adding those things EVMS needs kernel side into a cleaner
framework and the tools is better than two systems in one kernel. I
appreciate you guys doing what looks to be the right thing for the Linux
project overall even when it must be a bitter disappointment.

Alan

