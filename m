Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVFJHy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVFJHy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 03:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVFJHy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 03:54:58 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:55027 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261511AbVFJHyz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 03:54:55 -0400
Message-ID: <42A94611.8070502@lab.ntt.co.jp>
Date: Fri, 10 Jun 2005 16:49:37 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: andrea@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Real-time problem due to IO congestion.
References: <42A91D36.8090506@lab.ntt.co.jp> <20050610062452.GK5140@suse.de>
In-Reply-To: <20050610062452.GK5140@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens Axboe wrote:
> On Fri, Jun 10 2005, Takashi Ikebe wrote:
> 
> This basically needs io priorities to work, so that request allocation
> is prioritized as well. I didn't actually add request allocation groups
> in the cfq-ts posted with priority support, however I have some patches
> from years ago that did so. I'll see if I can find the time to brush
> those off.
> 

As you and andrew said, basically application based approach seems 
reasonable,
but I'm so interesting your patch, if you have time, please show me :-)

Thank you.

-- 
Takashi Ikebe
