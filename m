Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbSJIN37>; Wed, 9 Oct 2002 09:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261623AbSJIN37>; Wed, 9 Oct 2002 09:29:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19730 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261617AbSJIN36>;
	Wed, 9 Oct 2002 09:29:58 -0400
Message-ID: <3DA43094.8040104@pobox.com>
Date: Wed, 09 Oct 2002 09:35:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
References: <Pine.LNX.4.44.0210091243240.338-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> On Tue, 8 Oct 2002, Linus Torvalds wrote:
>>Some things made me go eww (but on the whole details):
>>
>> - I'd prefer the Config.in name, since this has nothing to do with
>>   building, and everything to do with configuration.
> 
> 
> Fine with me.
> (jgarzik, I think you're overruled now. :) )


Well, my basic preference is

* something other than Config.new (the original name in your config system)
* something other than Config.in

I think it is a mistake to name a totally different format the same name 
as an older format...  even "config.in" would be better than "Config.in"...


