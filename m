Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287513AbSBOHjj>; Fri, 15 Feb 2002 02:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287436AbSBOHj2>; Fri, 15 Feb 2002 02:39:28 -0500
Received: from [195.63.194.11] ([195.63.194.11]:38157 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287513AbSBOHjN>; Fri, 15 Feb 2002 02:39:13 -0500
Message-ID: <3C6CBB05.5010001@evision-ventures.com>
Date: Fri, 15 Feb 2002 08:38:45 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, Pavel Machek <pavel@suse.cz>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <Pine.LNX.4.33.0202141817300.14384-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Thu, 14 Feb 2002, Jeff Garzik wrote:
>
>>>But I'd like to see resulting epic100.tmpl ;-).
>>>
>>When you have to maintain more than 10 "cookie cutter" net drivers that
>>are 80-90% the same, you start to want such extremes :)
>>
>
>It's not necessarily a bad idea to have a more capable preprocessor than
>the C preprocessor. I've cursed preprocessor limitations before, and I
>there was some discussion about using m4 several years ago (and I mean
>_several_ years ago - if I were to guess I'd say 6-8 years ago..).
>

The idal solution would be some kind of stripped down C++ for some of 
those problems...
No rtti, no templates, no exceptions, no additional cruft requirng back 
behind you runtime
support for the language, but just plain simple direct struct 
inheritance kind off ;-).




