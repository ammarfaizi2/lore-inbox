Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314288AbSEMQx5>; Mon, 13 May 2002 12:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314287AbSEMQx4>; Mon, 13 May 2002 12:53:56 -0400
Received: from [195.63.194.11] ([195.63.194.11]:15635 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314288AbSEMQx4>; Mon, 13 May 2002 12:53:56 -0400
Message-ID: <3CDFE0DA.7010303@evision-ventures.com>
Date: Mon, 13 May 2002 17:50:50 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <3CDFAEC0.6050403@evision-ventures.com> <20020513134832.GV1106@suse.de> <3CDFB962.5070600@evision-ventures.com> <20020513153802.GB17509@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But beware that ide locking is a lot nastier than you think. I saw other
> irq changes earlier, I just want to make sure that you are _absolutely_
> certain that these changes are safe??

Well, I'm at least warned now to double check with the current
BIO stuff...


