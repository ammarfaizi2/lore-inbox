Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271586AbRHXONA>; Fri, 24 Aug 2001 10:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271578AbRHXOMv>; Fri, 24 Aug 2001 10:12:51 -0400
Received: from mail-gw.kns.com ([199.171.180.150]:14210 "EHLO mail-gw.kns.com")
	by vger.kernel.org with ESMTP id <S271505AbRHXOMb>;
	Fri, 24 Aug 2001 10:12:31 -0400
Message-ID: <3B8660D9.E108A8AA@eng.kns.com>
Date: Fri, 24 Aug 2001 10:12:42 -0400
From: Sergey Ostrovsky <sostrovs@kns.com>
X-Mailer: Mozilla 4.73 [en] (X11; I; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Bernhard Busch <bbusch@biochem.mpg.de>, linux-kernel@vger.kernel.org
Subject: Re: Poor Performance for ethernet bonding
In-Reply-To: <3B865882.24D57941@biochem.mpg.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Busch wrote:

> Hi
>
> I have tried to use ethernet  network interfaces bonding to increase
> peformance.
>
> Bonding is working fine, but the performance is rather poor.
> FTP between 2 machines ( kernel 2.4.4 and 4 port DLink 100Mbit ethernet
> card)
> results in a transfer rate of 3MB/s).

Slightly OT, but :
I had to return my 4 port DLink 10/100Mbit _switch_,
because this piece of junk dropped 50-70% of packets sent.
I'd suggest first to ping for some time and see statistics.

Sergey Ostrovsky.


