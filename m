Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286366AbSABTIK>; Wed, 2 Jan 2002 14:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287905AbSABTIB>; Wed, 2 Jan 2002 14:08:01 -0500
Received: from freeside.toyota.com ([63.87.74.7]:64784 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S286366AbSABTHt>; Wed, 2 Jan 2002 14:07:49 -0500
Message-ID: <3C335A77.806@lexus.com>
Date: Wed, 02 Jan 2002 11:07:35 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: brian@worldcontrol.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.17 vs 2.2.19 vs rml new VM
In-Reply-To: <20020102013305.A5272@top.worldcontrol.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just .02 from the peanut gallery -

It would be interesting if you were to compare and
contrast 2.4.17-preempt with 2.4.17-low-latency.

I find the low latency patch makes a noticeable
difference in e.g. q3a and rtcw - OTOH I have
not been able to discern any tangible difference
from the stock kernel when using -preempt.

cu

jjs

brian@worldcontrol.com wrote:

>I'd like to say that as of 2.4.17 w/preempt patch, the linux kernel
>seems again to perform as well as 2.2.19 for interactive use and
>reliability, at least in my use.
>
>2.4.17 still croaks running some of the giant memory applications
>that I run successfully on 2.2.19. (Machines with 2GB of RAM 
>running 3GB+ apps.)
>
>I tried rmap-10 new VM and under my typical load my desktop machine
>froze repeatedly.  Seemed the memory pool was going down the drain
>before the freeze. Meaning apps were failing and getting stuck in
>various odd states.
>
>No doubt, preempt and rmap-10 are incompatible, but I'm not going to
>give up the preempt patch any time soon.
>
>All in all 2.4.17 w/preempt is very satisfactory.
>


