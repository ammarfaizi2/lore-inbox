Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291110AbSBXUdN>; Sun, 24 Feb 2002 15:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289836AbSBXUdE>; Sun, 24 Feb 2002 15:33:04 -0500
Received: from [195.63.194.11] ([195.63.194.11]:48146 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291151AbSBXUcv>; Sun, 24 Feb 2002 15:32:51 -0500
Message-ID: <3C794DC0.7040706@evision-ventures.com>
Date: Sun, 24 Feb 2002 21:32:00 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Troy Benjegerdes <hozer@drgw.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org> <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <20020224013038.G10251@altus.drgw.net> <3C78DA19.4020401@evision-ventures.com> <20020224142902.C1682@altus.drgw.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Troy Benjegerdes wrote:
>>>Ummm, how does this work if I have two PCI ide cards, one on a 66mhz PCI 
>>>bus, and one on a 33mhz PCI bus?
>>>
>>>Or am I missing something?
>>>
>>You are missing the fact that it didn't work before.
 >
> What hardware, chipsets, situations, etc did the previous code not work
> on?

The previous code didn't distinguish the bus speed between different
busses and it doesn't do now as well.
It could be really helpfull to look at the patch actually. Don't you
think?

