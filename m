Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbUJZP4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUJZP4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbUJZP4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:56:37 -0400
Received: from siaag2ae.compuserve.com ([149.174.40.135]:45267 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S261241AbUJZP4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:56:16 -0400
Date: Tue, 26 Oct 2004 11:54:46 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BK kernel workflow
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200410261156_MC3-1-8D2C-C64C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

> But I have a 70 line shell script which does this, I'm not sure why you can't
> write the same thing.

  Shirley you jest.


>> [me@d4 linux-2.6]$ bk c2r -r@v2.6.9 mm/vmscan.c
>> [me@d4 linux-2.6]$                                               <--- what???
>
> That's because you didn't read the documentation which you appear to love 
> so much.

  So now it's MY fault I didn't get any kind of error message whatsoever?
Silent failures like this are really, really annoying...


>>   Then there's this one:
>> 
>> [me@d4 linux-2.6]$ bk difftool -rv2.6.8 -rv2.6.9 mm/vmscan.c     <--- forgot the @
>> child process exited abnormally                                  <--- hee hee!
>> 
>>   I like the way the GUI flashes up on the screen then abruptly disappears, leaving
>> the user wondering what happened.
>
> You know, I like the way you politely offer to help out by sending in
> patches to the documentation for this tool which you get to use for free.

  Are you deliberately missing my point?

  Programs should return some kind of error message when they fail.  Is that
so hard to understand?


>>   But you're located in a large American metro area, a.k.a. "hell on earth."
>
> No worries, Chuck, after careful consideration of your skills we don't see
> a match at this time.  But we'll keep your resume on file and thanks for
> your interest.

  Your loss, not mine.


--Chuck Ebbert  26-Oct-04  11:16:10
