Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264117AbRFFTkP>; Wed, 6 Jun 2001 15:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264118AbRFFTkG>; Wed, 6 Jun 2001 15:40:06 -0400
Received: from cloven-ext.nks.net ([216.139.204.130]:27396 "EHLO
	homer.mkintl.com") by vger.kernel.org with ESMTP id <S264117AbRFFTjz>;
	Wed, 6 Jun 2001 15:39:55 -0400
Message-ID: <3B1E8703.9D5A8EC2@illusionary.com>
Date: Wed, 06 Jun 2001 15:39:47 -0400
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106062048130.366-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> Can you try the patch below to see if it helps?  If you watch
> with vmstat, you should see swap shrinking after your test.
> Let is shrink a while and then see how long swapoff takes.
> Under a normal load, it'll munch a handfull of them at least
> once a second and keep them from getting annoying. (theory;)

Hi Mike,
I'll give that patch a spin this evening after work when I have time to
patch and recompile the kernel.

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
