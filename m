Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313044AbSDQIyq>; Wed, 17 Apr 2002 04:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313771AbSDQIyp>; Wed, 17 Apr 2002 04:54:45 -0400
Received: from [195.63.194.11] ([195.63.194.11]:20243 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313044AbSDQIyo>; Wed, 17 Apr 2002 04:54:44 -0400
Message-ID: <3CBD29BD.5090804@evision-ventures.com>
Date: Wed, 17 Apr 2002 09:52:29 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com> <3CBBCD31.4090105@evision-ventures.com> <3CBCA9B0.5010709@didntduck.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:

> 
> There is a typo in the cris ide driver ata_write value.  Also,
> e100_ideproc is now dead and can be removed.  Patch attached (untested, 
> but obvious).
>

You are right. And your patch does the proper thing.
I thank you very much for looking in to this!

