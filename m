Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313600AbSDHMhK>; Mon, 8 Apr 2002 08:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313588AbSDHMhK>; Mon, 8 Apr 2002 08:37:10 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19980 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313557AbSDHMhI>; Mon, 8 Apr 2002 08:37:08 -0400
Message-ID: <3CB1806F.9090103@evision-ventures.com>
Date: Mon, 08 Apr 2002 13:35:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] IDE tagged command queueing support
In-Reply-To: <20020408120713.GB25984@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Hi,
> 
> I've implemented tagged command queueing for ATA disk drives, and it's
> now ready for people to give it a test spin. As it has had only limited
> testing so far, please be very careful with it. It has been tested on
> two drives so far, a GXP75-30gb and a GXP120-40gb, and with a PIIX4
> controller:

OK after a cursory look I see that the patch contains quite
a lot of ideas for the generic code itself. Do you think that it would
be worth wile to extract them first or should the patch be just included
in mainline. (I don't intent to interferre too much with your efforts to
do something similar in 2.4.xx.)....

