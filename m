Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTDHRnN (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 13:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbTDHRnN (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 13:43:13 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:23530 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S261962AbTDHRnK (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 13:43:10 -0400
Date: Tue, 8 Apr 2003 13:52:01 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304081354_MC3-1-3386-1A33@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 
>> >> Have you looked at Stellation at all?  I know the
>> >> code itself is Java but they have some neat ideas about
>> >> being able to take 'slices' across the repository and
>> >> treat the slice as a single file for things like revision
>> >> tracking.  
>> >
>> > Except that those are ideas as far as I can tell, not actual code.
>> 
>>  Last I saw they had a prototype that worked better than they expected.
>
> Which you've installed and tried, right?


 Heh.  The whole Eclipse/CDT/Stellation assemblage takes so much work
just to get off the ground it's not even funny, not to mention their
directions for putting Stellation on Oracle are curiously empty.


>  I just poked through their 
> website and I can't find anywhere in the code or docs where it says 
> they have the 'slices' idea implemented.  They certainly talk about
> it a lot.


  Did you look in the changelog?


>>   1. Keep the csets separate but link them together.  Let the developer
>>      tell the system whether one is an enhancement or a bugfix to the base.
>
> BK already does this.


Can I somehow 'collapse' the csets together when browsing the repository?
A nice example might be the recent ethernet padding fix, where there ended
up being a whole set of separate patches.  By looking through the
comments I can piece together a complete patch, but it's painful.

--
 Chuck
 I am not a number!
