Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291019AbSAaLUz>; Thu, 31 Jan 2002 06:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291020AbSAaLUq>; Thu, 31 Jan 2002 06:20:46 -0500
Received: from [195.63.194.11] ([195.63.194.11]:45322 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291019AbSAaLU3>; Thu, 31 Jan 2002 06:20:29 -0500
Message-ID: <3C592870.10206@evision-ventures.com>
Date: Thu, 31 Jan 2002 12:20:16 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Christoph Hellwig <hch@ns.caldera.de>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com, axboe@suse.de
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <200201291313.g0TDDd716906@ns.caldera.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>Hi Martin,
>
>In article <3C568C52.2060707@evision-ventures.com> you wrote:
>
>>>One "patch penguin" scales no better than I do. In fact, I will claim
>>>that most of them scale a whole lot worse. 
>>>
>>Bla bla bla... Just tell how frequenty do I have to tell the world, that 
>>the read_ahead array is a write
>>only variable inside the kernel and therefore not used at 
>>all?????!!!!!!!!!!
>>
>
>It IS used. (hint: take a look at fs/hfs/file.c).
>

Right, but the usage there is semantically *invalid*.


