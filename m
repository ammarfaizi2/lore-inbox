Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbUJYTzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUJYTzN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbUJYTyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:54:47 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:45201 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261227AbUJYTvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:51:37 -0400
Message-ID: <417D59DF.1080807@tmr.com>
Date: Mon, 25 Oct 2004 15:54:07 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avuton Olrich <avuton@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
References: <20041022032039.730eb226.akpm@osdl.org><20041022032039.730eb226.akpm@osdl.org> <3aa654a404102300221317f104@mail.gmail.com>
In-Reply-To: <3aa654a404102300221317f104@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich wrote:
> On Fri, 22 Oct 2004 03:20:39 -0700, Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>  - reiser4: not sure, really.  The namespace extensions were disabled,
>>    although all the code for that is still present.  Linus's filesystem
>>    criterion used to be "once lots of people are using it, preferably when
>>    vendors are shipping it".  That's a bit of a chicken and egg thing though.
>>    Needs more discussion.
> 
> 
> *Disclamer: My first post to the list, sorry if something's wrong with
> it (blame gmail ;P)*
> 
> I've been using reiser4 in four of my computers since it was in -mm.
> All partitions (excl. /boot), including 2 boxes that have been up
> since (well, reboots for -mm updates from time to time) the reiser4
> conversion and not a hiccup since. I'm always shocked when people
> speak about how my computers are going to blow up, how people who run
> reiser4 must be insane, etc... I've heard it all. Truth is, at the end
> of the day, me, Joe End User, has had no issues. I'm not here to say
> it's perfect (only the programmers know for sure, IANAP), but it's far
> from unpredictable.

Are you running 4k or 8k stack?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
