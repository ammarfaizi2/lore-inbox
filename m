Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318945AbSHSQ4l>; Mon, 19 Aug 2002 12:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318947AbSHSQ4k>; Mon, 19 Aug 2002 12:56:40 -0400
Received: from taco.vianet.on.ca ([209.91.128.11]:43483 "HELO smtp.vianet.ca")
	by vger.kernel.org with SMTP id <S318945AbSHSQ4k>;
	Mon, 19 Aug 2002 12:56:40 -0400
Message-ID: <3D61243A.8040304@thirddimension.net>
Date: Mon, 19 Aug 2002 13:00:42 -0400
From: Reid Sutherland <reid-lkml@thirddimension.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Interrupt issue with 2.4.19 vs 2.4.18.
References: <3D5D527E.5030607@thirddimension.net> 	<20020819155421.GA10726@titan.lahn.de> <1029774904.19375.40.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>My board has a Intel 440GX chipset.  From my understanding these are a 
>>bitch to deal with and are littered with bugs.  I've also read that by 
> 
> 
> Not bugs. Intel refusal to provide documentation on the IRQ routing for
> them

Ahh just lovely.  Any known hack/workaround?

(pci=noacpi doesn't work)

-reid



