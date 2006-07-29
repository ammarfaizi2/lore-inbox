Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWG2TUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWG2TUM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWG2TUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:20:12 -0400
Received: from mail.tmr.com ([64.65.253.246]:6600 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S932216AbWG2TUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:20:10 -0400
Message-ID: <44CBB5BB.10009@tmr.com>
Date: Sat, 29 Jul 2006 15:23:39 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspend2 merge history [was Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
References: <44C42B92.40507@xfs.org> <17604.31844.765717.375423@gargle.gargle.HOWL> <20060724103023.GA7615@thunk.org> <20060724113534.GA64920@dspnet.fr.eu.org> <20060724133939.GA11353@thunk.org> <20060724153853.GA88678@dspnet.fr.eu.org> <20060726130806.GA5270@ucw.cz> <20060727155222.GA30593@dspnet.fr.eu.org> <20060727214224.GB3797@elf.ucw.cz> <20060727232249.GA25993@dspnet.fr.eu.org> <20060728140059.GD4623@ucw.cz>
In-Reply-To: <20060728140059.GD4623@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Fri 28-07-06 01:22:49, Olivier Galibert wrote:
>> On Thu, Jul 27, 2006 at 11:42:25PM +0200, Pavel Machek wrote:
>>> So we have 1 submission for review in 11/2004 and 1 submission for -mm
>>> merge in 2006, right?
>> Wrong.  I gave a list of dates at the beginning of the month, do you
>> think I threw dice to get them?
>>
>> And could you explain, as suspend maintainer for the linux kernel, how
>> come code submitted for the first time two years ago and with a much
>> better track record than the in-kernel one is still not in?
> 
> Because Nigel has too much of code to start with, and refuses to fix
> his design because it would invalidate all the stabilization work.

Why should he invalidate his stabilization work, and what's in need of 
fixing? The suspend in the kernel is great, but suspend2 includes both 
suspend and working resume code as well.
> 
> Plus Nigel did not do very good job with submitting those patches.

They apply, they work. What's not very good about that? Is this being 
blocked because of a spelling error, or did he mess up the indenting on 
"signed off by" or what? I realize you may have something other than the 
download version, but it's been years now.

I would like to see the working suspend (suspend2) in the kernel, and 
users wanting to debug the resume stuff currently in the kernel could 
get it under EXPERIMENTAL or some such.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
