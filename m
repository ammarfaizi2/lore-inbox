Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVKLL6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVKLL6R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 06:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVKLL6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 06:58:17 -0500
Received: from [195.144.244.147] ([195.144.244.147]:7350 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S932356AbVKLL6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 06:58:16 -0500
Message-ID: <4375D8D4.9010605@varma-el.com>
Date: Sat, 12 Nov 2005 14:58:12 +0300
From: Andrey Volkov <avolkov@varma-el.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: Luke Yang <luke.adi@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: ADI Blackfin patch for kernel 2.6.14
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>	 <20051101165136.GU8009@stusta.de>	 <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>	 <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>	 <20051104230644.GA20625@kroah.com>	 <489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>	 <20051107165928.GA15586@kroah.com>	 <20051107235035.2bdb00e1.akpm@osdl.org> <489ecd0c0511110326j3a01cabbheeeac6168193a0b0@mail.gmail.com>
In-Reply-To: <489ecd0c0511110326j3a01cabbheeeac6168193a0b0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Yang wrote:
>>Does this architecture support SMP?  I see it's BROKEN_ON_SMP, but there
>>seems to be some smp-style stuff in there.
> 
> 
>    It doesn't support SMP now.

Wrong, how about dual core BF56x subfamily? It's true SMP beast.
Or you are try to told that "current SOFTWARE arch doesn't
support it yet", am I right?

Also, returning to previous posts, ALL BF5xx have normal
MMU (which possible not so useful for DSP tasks).

--
Regards
Andrey Volkov

