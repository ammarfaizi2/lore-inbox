Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSDRNBl>; Thu, 18 Apr 2002 09:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314341AbSDRNBk>; Thu, 18 Apr 2002 09:01:40 -0400
Received: from [195.63.194.11] ([195.63.194.11]:37393 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314340AbSDRNBk>; Thu, 18 Apr 2002 09:01:40 -0400
Message-ID: <3CBEB51F.90105@evision-ventures.com>
Date: Thu, 18 Apr 2002 13:59:27 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <02db01c1e498$7180c170$58dc703f@bnscorp.com> <20020416102510.GI17043@suse.de> <20020416200051.7ae38411.sebastian.droege@gmx.de> <20020416180914.GR1097@suse.de> <20020416204329.4c71102f.sebastian.droege@gmx.de> <3CBD28D1.6070702@evision-ventures.com> <20020417132852.4cf20276.sebastian.droege@gmx.de> <3CBD519F.7080207@evision-ventures.com> <20020418141746.2df4a948.sebastian.droege@gmx.de> <3CBEABEF.1030009@evision-ventures.com> <20020418125757.GF2492@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Apr 18 2002, Martin Dalecki wrote:
> 
>>BTW>  Jens: Do you have any idea what the "sector chaing" in ide-cd is
>>good for?! I would love to just get rid of it alltogether!
> 
> 
> Sector chaining? Are you talking about the cdrom_read_intr() comments?

Sorry I did mean sector caching.

