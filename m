Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132590AbRDRC1A>; Tue, 17 Apr 2001 22:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132795AbRDRC0t>; Tue, 17 Apr 2001 22:26:49 -0400
Received: from winds.org ([207.48.83.9]:11536 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S132590AbRDRC0d>;
	Tue, 17 Apr 2001 22:26:33 -0400
Date: Tue, 17 Apr 2001 22:26:26 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: Jason Thomas <jason@topic.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac9
In-Reply-To: <20010418120102.B29749@topic.com.au>
Message-ID: <Pine.LNX.4.21.0104172224320.8771-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2001, Jason Thomas wrote:

> Alan,
> 
> This does not seem to fix the problem with "clock timer", which
> repeatedly prints the following message:
> 
> probable hardware bug: clock timer configuration lost - probably a VIA686a motherboard.
> probable hardware bug: restoring chip configuration.
> 
> The machine does not get any further than printing the above message.
> This message only appears with an SMP kernel, there are no ide devices
> in the machine.

I've seen this on my Dell P3 700 machine several times. Seems to happen at odd
intervals after I use my CD burner, but that just might be coincidental. But
I'd like to point out that I've never seen this on my VIA686a itself. The P3
machine is UP too, not SMP. I saw this ever since I switched the machine to
2.4.2-ac8 and beyond (previously 2.2.18).

 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

