Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbUKCW5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbUKCW5y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbUKCWz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:55:28 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:47745 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261938AbUKCWv2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:51:28 -0500
Message-ID: <41896198.8080308@tmr.com>
Date: Wed, 03 Nov 2004 17:54:16 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Clemens Schwaighofer <cs@tequila.co.jp>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: still no cd/dvd burning as user with 2.6.9
References: <41889857.5040506@tequila.co.jp>
In-Reply-To: <41889857.5040506@tequila.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer wrote:

> Hi,
> 
> I use 2.6.9-ac3 on my Laptop and I just wanted to burn a DVD-Video with
> my external Pioneer DVD writer which is connected via fire-wire to the
> Laptop.
> 
> Before 2.6.9-ac3 I used 2.6.9-rc2-mm2 and with this I could write CDs/DVDs.
> 
> <rant>
> So why is it still impossible that users can write CDs/DVDs. I, as a
> user, find this rather ridicolous that you have to patch the kernel to
> get this simple thing running. Security is important, yes, but this is
> just annoying.

Security is important, there are no buts about it. See the almost 
endless thread on this earlier. You can run your burns as root, of course.
> 
> I really hope that gets fixed soon, because its just annoying to reboot
> to a different kernel, just to write CDs ...
> </rant>

I'm not sure what you consider "fixed" in this context, but if you mean 
disabled security I don't personally expect (or want) that.

Someone claimed that cdrecord could get RR scheduling with attributes 
set (did they mean capabilities?), but I haven't seen a working example 
  yet.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
