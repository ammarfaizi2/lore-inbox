Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318218AbSIJXki>; Tue, 10 Sep 2002 19:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318219AbSIJXki>; Tue, 10 Sep 2002 19:40:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4869 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318218AbSIJXki>;
	Tue, 10 Sep 2002 19:40:38 -0400
Message-ID: <3D7E83F4.6050302@mandrakesoft.com>
Date: Tue, 10 Sep 2002 19:44:52 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.5
References: <3D7E7D5F.F37D2D49@linux-m68k.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> At http://www.xs4all.nl/~zippel/lc/lkc-0.5.tar.gz you can find the
> latest version of the new config system. Besides various small bug
> fixes, it includes the following changes:
> - Improved mouse interface of qconf
> - qconf isn't build if QT isn't available
> - "if" ... "endif" block added
> - update to 2.5.35
> 
> With the exception of the X interface I'm not planning any big visible
> changes anymore, so slowly I'd like to know any reason, why this config
> system shouldn't go into 2.5.x.
[...]
> Otherwise the little feedback I got was mostly positive, so if anything
> thinks the old config system is in any way better, I'd really like to
> know about it now (and if anyone wants to keep the old system, (s)he
> just volunteered to fix all the subtle differences between the three
> different parsers). So unless I hear objections rather soon, it's up to
> Linus.


How about posting a kernel patch (or link to one) that you feel is 
suitable for 2.5.x integration?  That makes it a bit easier to review in 
context, and may help to resolve any final integration issues.

For the record I like what I've seen so far...

	Jeff



