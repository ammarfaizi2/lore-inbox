Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbRLMQHk>; Thu, 13 Dec 2001 11:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284307AbRLMQHb>; Thu, 13 Dec 2001 11:07:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:64898 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S284305AbRLMQHX>; Thu, 13 Dec 2001 11:07:23 -0500
Date: Thu, 13 Dec 2001 11:07:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: DevilKin <devilkin@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: User/kernelspace stuff to set/get kernel variables
In-Reply-To: <20011213155532Z284289-18284+114@vger.kernel.org>
Message-ID: <Pine.LNX.3.95.1011213110539.4556A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, DevilKin wrote:

> Hello
> 
> I've been looking on the web, and couldn't really find what i would want...
> 
> Basically: is it possible to - one way or another - set variables at kernel boot and read those using userspace utilities?
> 
> for instance: i boot my kernel (using any old bootmanager that accepts kernel params)
> 
> 
> LILO: linux network=dhcp
> 

Is this what you want?

`cat /proc/cmdline`


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
 Santa Claus is coming to town...
          He knows if you've been sleeping,
             He knows if you're awake;
          He knows if you've been bad or good,
             So he must be Attorney General Ashcroft.


