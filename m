Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261743AbSJIOIA>; Wed, 9 Oct 2002 10:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbSJIOH7>; Wed, 9 Oct 2002 10:07:59 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:505 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261743AbSJIOHy>; Wed, 9 Oct 2002 10:07:54 -0400
Message-ID: <3DA439B2.3000801@bigpond.com>
Date: Thu, 10 Oct 2002 00:14:10 +1000
From: Brendan J Simon <brendan.simon@bigpond.com>
Reply-To: brendan.simon@bigpond.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: linux kernel conf 0.8
References: <Pine.LNX.4.44.0210091546070.8911-100000@serv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Roman Zippel wrote:

>>Well, my basic preference is
>>
>>* something other than Config.new (the original name in your config system)
>>* something other than Config.in
>>
>>I think it is a mistake to name a totally different format the same name
>>as an older format...  even "config.in" would be better than "Config.in"...
>>    
>>
>
>My first plan was to use Config.in, but I can't overwrite the old files
>yet, so I named it Config.new. Personally I only prefer that it starts
>with a capital letter (like Makefile, Readme), so it's at the top of a
>dir listing, but otherwise I don't care much about the name.
>

Simple and boring but how about "Config2.in" or "Config-2.in" ???

Regards,
Brendan Simon.


