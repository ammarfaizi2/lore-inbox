Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272212AbRIEP4g>; Wed, 5 Sep 2001 11:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272213AbRIEP41>; Wed, 5 Sep 2001 11:56:27 -0400
Received: from cpe-24-221-114-147.az.sprintbbd.net ([24.221.114.147]:19840
	"EHLO localhost.digitalaudioresources.org") by vger.kernel.org
	with ESMTP id <S272212AbRIEP4R>; Wed, 5 Sep 2001 11:56:17 -0400
Message-ID: <3B964B29.8080400@digitalaudioresources.org>
Date: Wed, 05 Sep 2001 08:56:25 -0700
From: David Hollister <david@digitalaudioresources.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Eric Olson <ejolson@unr.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
In-Reply-To: <200109050521.WAA26155@equinox.unr.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Olson wrote:
> Robert Redelmeier told me he has written a version of his burnMMX which 
> uses K7 MMX 3DNow streaming cache bypass load/store instruction sequences
> similar to what is used in linux/arch/i386/lib/mmx.c
>  
> It would be particularly interesting if someone with a problematic KT133A 
> based motherboard would test it and report back.

Ran both burnK7 and burnMMX for 10+ minutes with no problems.  FWIW, burnMMX 
didn't do much to my system temp, but burnK7 raised it by a good 8-9 degrees.

-- 
David Hollister
Driversoft Engineering:  http://devicedrivers.com
Digital Audio Resources: http://digitalaudioresources.org

