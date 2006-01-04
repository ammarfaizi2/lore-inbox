Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWADWty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWADWty (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWADWty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:49:54 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:31628 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750788AbWADWtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:49:53 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Nick Warne <nick@linicks.net>
Cc: Greg KH <greg@kroah.com>, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
Date: Thu, 05 Jan 2006 09:49:45 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <esjor11m4qu0tob1efjsebj10e5caeuu38@4ax.com>
References: <200601041710.37648.nick@linicks.net> <200601042210.47152.nick@linicks.net> <20060104221549.GA13254@kroah.com> <200601042220.59637.nick@linicks.net>
In-Reply-To: <200601042220.59637.nick@linicks.net>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 22:20:59 +0000, Nick Warne <nick@linicks.net> wrote:

>On Wednesday 04 January 2006 22:15, Greg KH wrote:
>
>> > Then when 2.6.15 came out, that was it!  No patch for the 'latest stable
>> > kernel release 2.6.14.5'.  It was GONE!
>>
>> That's because 2.6.15 is the latest stable release.
>>
>> > OK, I suppose we are all capable of getting back to where we are on
>> > rebuilding to latest 'stable', but there _is_ a missing link for somebody
>> > that doesn't know - and I think backtracking patches isn't really the way
>> > to go if the 'latest stable release' isn't catered for.
>>
>> Um, it is, see my sentance above.  And if you want to download older
>> stable releases, you can jump to the proper directory, how long do you
>> want us to put older stable releases on the main page for?  :)
>
>OK, I see what you mean, but 2.6.14 wasn't the latest 'release' - 2.6.14.5 was 
>(according to kernel.org).  Yet there is no upgrade path for that build (or 
>any other .x releases)
>
>It is a bit of a mess really.

Nah, search the archives for 'sucker tree' -- was much worse before 
we have the stable bugfix patchlets in between the main kernel 
releases, there was never going to be a 2.6.X.Y to 2.6.X+1 patch as 
mainstream kernel development may fix issues entirely differently.

Kernel development is an ongoing process, the stable trees are 
temporary branches outside of (or beside) mainstream development, 
that easier for you?

Grant.
