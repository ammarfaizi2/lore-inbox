Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316456AbSGEJfv>; Fri, 5 Jul 2002 05:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSGEJfu>; Fri, 5 Jul 2002 05:35:50 -0400
Received: from mail.zmailer.org ([62.240.94.4]:35280 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S316456AbSGEJft>;
	Fri, 5 Jul 2002 05:35:49 -0400
Date: Fri, 5 Jul 2002 12:38:22 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Matthias Welk <welk@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem: socket receivebuffer size
Message-ID: <20020705123822.W28720@mea-ext.zmailer.org>
References: <200207051128.06598.welk@fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207051128.06598.welk@fokus.gmd.de>; from welk@fokus.gmd.de on Fri, Jul 05, 2002 at 11:28:05AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2002 at 11:28:05AM +0200, Matthias Welk wrote:
> Hi,
> 
> I've a problem with sockets and the receive buffer size.
> If the size is smaller than 831 (??) byte, I did not receive udp packets
> (224 byte) any more.

  Yes ?    Why are you setting it so low ?
  Having there some larger value, like 64k, should not harm anything,
  quite contrary.

> Syetem:
> RedHat 7.2 i386
> 3Com Corporation 3c905B 100BaseTX [Cyclone]
> kernel 2.4.9-31
> 
> Thanks, Matthias.
>       10589 Berlin		      email : welk@fokus.fhg.de

/Matti Aarnio
