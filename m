Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315577AbSEVOtC>; Wed, 22 May 2002 10:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSEVOrs>; Wed, 22 May 2002 10:47:48 -0400
Received: from [195.63.194.11] ([195.63.194.11]:39952 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315539AbSEVOqT>; Wed, 22 May 2002 10:46:19 -0400
Message-ID: <3CEBA061.7030207@evision-ventures.com>
Date: Wed, 22 May 2002 15:42:57 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: jack@suse.cz, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.GSO.4.21.0205221035150.2737-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alexander Viro napisa?:
> 
> On Wed, 22 May 2002, Martin Dalecki wrote:
> 
> 
>>2. Typical string formating and value copy and termination
>>     problems inherent to string stuff...
> 
> 
> s/inherent to/inherent to incompetently written/
> 
> BTW, quoted code should've used seq_file helpers - that would both
> cut the code size way down and fix the damn thing.

Ah... I think I will just provide the step toward the
/proc/sys/fs. Code talks best I think in this case.

jack would you mind it?
Are there any user land tool issues I should keep an eye
on?

