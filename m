Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287838AbSBMQ43>; Wed, 13 Feb 2002 11:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287840AbSBMQ4L>; Wed, 13 Feb 2002 11:56:11 -0500
Received: from [195.63.194.11] ([195.63.194.11]:57865 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287838AbSBMQzt>; Wed, 13 Feb 2002 11:55:49 -0500
Message-ID: <3C6A9A7F.8020601@evision-ventures.com>
Date: Wed, 13 Feb 2002 17:55:27 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: torvalds@transmeta.com, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <3C6A5D79.33C31910@mandrakesoft.com>	<Pine.LNX.4.33.0202131028130.13632-100000@home.transmeta.com> <20020213.084952.68037450.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>   From: Linus Torvalds <torvalds@transmeta.com>
>   Date: Wed, 13 Feb 2002 10:30:48 -0800 (PST)
>   
>   Basic rule: it's up to _other_ architectures to fix drivers that don't
>   work for them. Always has been. Because there's no way you can get the
>   people who just want to have something working to care.
>
>And if nobody else ends up doing it, you are right it will be people
>like Jeff and myself doing it.
>
>So what we are asking is to allow a few weeks for that and not crap up
>the tree meanwhile.  This is so that the cases that need to be
>converted are harder to find.
>
If you try to use them, then they are not hard to find - things just 
break for you and you fix tem.
If you are fixing things for the "store" Linus is right that indeed it's 
just a waiste of time on your behalf.

>Actually, you're only half right in one regard.  Most people I've
>pointed to Documentation/DMA-mapping.txt have responded "Oh, never saw
>that before, that looks easy to do.  Thanks I'll fix it up properly
>for you."
>


