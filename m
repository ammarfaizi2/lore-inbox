Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSLCWJa>; Tue, 3 Dec 2002 17:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266319AbSLCWJa>; Tue, 3 Dec 2002 17:09:30 -0500
Received: from transport.cksoft.de ([62.111.66.27]:4872 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S262826AbSLCWJ3>; Tue, 3 Dec 2002 17:09:29 -0500
Date: Tue, 3 Dec 2002 22:18:33 +0000 (UTC)
From: bzeeb-lists@zabbadoz.net
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reserving physical memory at boot time
In-Reply-To: <1038952684.11426.106.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.BSF.4.44.0212032203110.22086-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Dec 2002, Alan Cox wrote:

> On Tue, 2002-12-03 at 21:11, Richard B. Johnson wrote:
> > If you need a certain page reserved at boot-time you are out-of-luck.
>
> Wrong - you can specify the precise memory map of a box as well as use
> mem= to set the top of used memory. Its a painful way of marking a page
> and it only works for a page the kernel isnt loaded into.

short question - is it also possible to mark some "bad addresses" in a
quite similar way ? I know RAM is cheep these days but...

Memory with just one bad address or two would be good enough to be
able to use them in a desktop pc again if the kernel could make sure
that these addresses will never be accessed/used from anyone.

Next step for HA in servers then would be a memory raid ;-) but for
sure big blue holds some patents on this :(

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

