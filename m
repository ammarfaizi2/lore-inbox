Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280436AbRJaTaR>; Wed, 31 Oct 2001 14:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280439AbRJaTaH>; Wed, 31 Oct 2001 14:30:07 -0500
Received: from dispatch.lakeheadu.ca ([216.211.0.8]:12303 "HELO
	dispatch.lakeheadu.ca") by vger.kernel.org with SMTP
	id <S280436AbRJaT36>; Wed, 31 Oct 2001 14:29:58 -0500
Message-ID: <3BE050A6.90404@mail.myrealbox.com>
Date: Wed, 31 Oct 2001 14:27:34 -0500
From: "Daniel R. Warner" <drwarner@mail.myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.5) Gecko/20011019
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6 + preempt dri lockup
In-Reply-To: <20011031152822Z280263-17408+8294@vger.kernel.org> <3BE04DE8.F012C592@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:

> Just a data point -
> 
> Running 2.4.14-pre6 + preempt + a.m.  low latency
> Hardware = PIII-933 on intel mobo, 512 MB
> Video = voodoo3 agp
> 
[snip] 
> So there may be specific driver bugs which
> are being invoked in your situation.

I have a 2.4.12-ac6 + preempt system
Hardware = K6-2/400 on MSI mobo, 256 mb
Video = voodoo3 agp

I experience random lockups and crashes in UT and Q3.
(not particularly concerned about it though)
I have not experienced any problems with this box outside of DRI.
-d


