Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVCKTkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVCKTkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVCKTf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:35:56 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:13712 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261563AbVCKTd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:33:56 -0500
Message-ID: <4231F3DF.1010206@tmr.com>
Date: Fri, 11 Mar 2005 14:39:11 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: "Theodore Ts'o" <tytso@mit.edu>, Moritz Muehlenhoff <jmm@inutil.org>,
       Martin Josefsson <gandalf@wlug.westbo.se>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Average power consumption in S3?
References: <20050311034615.GA314@thunk.org><20050309142612.GA6049@informatik.uni-bremen.de> <1110516679.32557.350.camel@gaston>
In-Reply-To: <1110516679.32557.350.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> I've sort-of been waiting for ATI to tell me how to retreive the proper
> memory register setting from the BIOS, since the code in there currently
> is quite powerbook specific, and might not write the exact correct value
> on all models. I suppose it works fine on yours so far, but I'd rather
> have a way to know the right value ... unfortunately, they didn't reply
> on this request.

Any chance that it will apply to other Radeon based machines? I have an 
ASUS (1681) using the 8700 chipset. At the moment suspecd doesn't work 
at all, but at least somewhere in 2.6.10+ turning off the backlight 
started working with the screen saver.

I guess it's better than my Dell and Toshiba laptops, which suspecnd but 
don't resume :-(

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
