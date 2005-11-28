Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVK1PX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVK1PX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 10:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVK1PX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 10:23:26 -0500
Received: from kirby.webscope.com ([204.141.84.57]:43996 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1751277AbVK1PXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 10:23:25 -0500
Message-ID: <438B1F89.7000402@linuxtv.org>
Date: Mon, 28 Nov 2005 10:17:29 -0500
From: Mike Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Marco d'Itri" <md@Linux.IT>
CC: Duncan Sands <duncan.sands@math.u-psud.fr>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Re: saa7134 broken in 2.6.15-rc2
References: <20051128135254.GA4218@wonderland.linux.it> <200511281501.32949.duncan.sands@math.u-psud.fr> <20051128141003.GA4806@wonderland.linux.it>
In-Reply-To: <20051128141003.GA4806@wonderland.linux.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco d'Itri wrote:

>On Nov 28, Duncan Sands <duncan.sands@math.u-psud.fr> wrote:
>
>>here seems to be something rotten in v4l land; here's one I got with 2.6.15-rc1-git1
>>    
>>
>Yes, I should have STFW better: http://lkml.org/lkml/fancy/2005/11/24/194 .
>
>video-buf is still broken for me in -rc2, I can make xawtv work if I set
>capture to "overlay", but it still complain about no input sources other
>than "default".
>
Please try again, using the current -git snapshot.... The memory 
problems have been fixed by Hugh Dickins in 2.6.15-rc2-git3 , and Dmitry 
has submitted some input fixes after that.....

I am running 2.6.15-rc2-git6 with no problems.

If you are still having problems, please let us know, being sure to cc 
the v4l mailing list.

Cheers,

Michael Krufky


