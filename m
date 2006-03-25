Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWCYAvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWCYAvW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWCYAvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:51:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55773 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751310AbWCYAvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:51:21 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans
References: <20060322205305.0604f49b.akpm@osdl.org>
	<m1k6ajct9a.fsf@ebiederm.dsl.xmission.com>
	<20060324155332.4639a9c2.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Mar 2006 17:50:29 -0700
In-Reply-To: <20060324155332.4639a9c2.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 24 Mar 2006 15:53:32 -0800")
Message-ID: <m1k6ajfiui.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>> Andrew Morton <akpm@osdl.org> writes:
>> 
>> >   This is Oleg's romp through the core kernel.  There's a ton of material
>> >   here.  I'll probably send it all to Linus and ask him to review it.  (aka
>> >   blame-shifting).
>> 
>> A couple of those are mine... :)
>> 
>> >   Eric's romp through /proc.  Scary, not sure yet.
>> 
>> And a couple of these were Oleg's :)
>
> You're just trying to trick me into thinking that you're different guys.

>> Anything that can be done to make these less scary?
>
> Nothing clever that I can think of, no.  It's just a whole lot of code in
> areas which are tricky and in which few people work and in which reviewing
> resources are slight.

Ok.  Thanks.  At least I now know why it is scary.

> We'll have a couple of months to shake things out.  Any lingering problems
> will be small.  As long as the small-lingering-problems aren't security
> holes then OK, that's liveable with.

Eric
