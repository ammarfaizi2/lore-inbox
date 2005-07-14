Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVGNNjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVGNNjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbVGNNjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:39:19 -0400
Received: from relay02.pair.com ([209.68.5.16]:49671 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S261382AbVGNNjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:39:18 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42D66B03.7000906@cybsft.com>
Date: Thu, 14 Jul 2005 08:39:15 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Chuck Harding <charding@llnl.gov>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
References: <200507091704.12368.s0348365@sms.ed.ac.uk> <200507111455.45105.s0348365@sms.ed.ac.uk> <20050711141232.GA16586@elte.hu> <20050711141622.GA17327@elte.hu> <20050711150711.GA19290@elte.hu> <1121198946.10580.13.camel@mindpipe> <Pine.LNX.4.63.0507121331480.9097@ghostwheel.llnl.gov> <20050713103930.GA16776@elte.hu> <42D51EAF.2070603@cybsft.com> <Pine.LNX.4.63.0507131228280.6886@ghostwheel.llnl.gov> <20050713194507.GA5493@elte.hu>
In-Reply-To: <20050713194507.GA5493@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Chuck Harding <charding@llnl.gov> wrote:
> 
> 
>>I missed getting -51-29 but just booted up -51-30 and all is well. 
>>Thanks. Just out of curiosity, what was changed between -51-28, 29, 
>>and 30?
> 
> 
> -51-29 had new IO-APIC optimizations - and i reverted them in -51-30.
> 
> 	Ingo

Ingo,

I just noticed that the keyboard repeat problem is back in a bad way in 
-51-30. I was not seeing this before I left this PC about 16     hours 
ago. And the uptime is:
  08:34:10 up 18:46,  7 users,  load average: 3.32, 3.24, 2.53

-- 
    kr
