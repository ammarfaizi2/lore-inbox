Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbSJIOB6>; Wed, 9 Oct 2002 10:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbSJIOB6>; Wed, 9 Oct 2002 10:01:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34052 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261737AbSJIOB4>;
	Wed, 9 Oct 2002 10:01:56 -0400
Message-ID: <3DA43830.9010308@pobox.com>
Date: Wed, 09 Oct 2002 10:07:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
References: <Pine.LNX.4.44.0210091546070.8911-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Wed, 9 Oct 2002, Jeff Garzik wrote:
> 
> 
>>Well, my basic preference is
>>
>>* something other than Config.new (the original name in your config system)
>>* something other than Config.in
>>
>>I think it is a mistake to name a totally different format the same name
>>as an older format...  even "config.in" would be better than "Config.in"...
> 
> 
> My first plan was to use Config.in, but I can't overwrite the old files
> yet, so I named it Config.new.

yeah, I understood it was a temporary name, I just wanted to make sure 
the name was changed fairly soonish, so we could have this filename 
debate :)


 > Personally I only prefer that it starts
> with a capital letter (like Makefile, Readme), so it's at the top of a
> dir listing, but otherwise I don't care much about the name.

That's fine with me.  My only preference is anything-but-Config.in, for 
the reason stated in the last email...

	Jeff



