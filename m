Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbUJZVEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbUJZVEB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbUJZVEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:04:01 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:21486 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261471AbUJZVAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:00:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Plzsy7rTYvsB6Wmz57Imft+gfH1mMpkNWMA6qIyYNGcHu4ueIx9iOr1wBKDSQkdMIJJuL/+GSFeueiot1QWplBN7ahga57Ujay5P6uN++D8ZTvrVpo4XyGsIfpMW5li9LSCcR6ezAqycFTn/SO0TOeu0HB7FQJAJydQe2L3HZdM=
Message-ID: <4d8e3fd304102614002285559e@mail.gmail.com>
Date: Tue, 26 Oct 2004 23:00:43 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Let's make a small change to the process
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, alan@lxorguk.ukuu.org.uk,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <417EB83B.90707@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410260644.47307.edt@aei.ca>
	 <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin>
	 <4d8e3fd3041026050823d012dc@mail.gmail.com>
	 <877jpdcnf5.fsf@barad-dur.crans.org>
	 <4d8e3fd304102613165b2fb283@mail.gmail.com>
	 <417EB83B.90707@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 16:48:59 -0400, John Richard Moser
<nigelenki@comcast.net> wrote:
[...]
> 
> | We, of course, need a maintainer for it,
> 
> Yes, a little too much to maintain though isn't it?  Maintainers to
> continuously upkeep revisions that come out every few weeks potentially?
> ~ Remember it's got to be able to withstand the test of time for quite a
> while; why are people still maintaining 2.2?
> 
> | maybe someone from OSDL (Randy?), maybe wli (he maintained his tree
> | for a long time), maybe Alan (that is already applying these kind of
> | fixes to his tree), maybe someone else... ?
> |
> 
> Common courteousy, don't volunteer people.  :)

Just wrote name a few "famous" and "great" kernel hackers :)
 
> | Sounds reasonable ?
> |
> 
> Sounds too fast.  I don't predict having a maintainer for each minor
> release of the kernel (which is what you're saying here essentially), so
> there'd be a need for one or a handfull of maintainers to spend loads of
> time backporting fixes to a quickly mounting set of kernels.

Yes, one maintainer.
But I'm not sure that each minor release of ther kernel needs a .Y version.
 
> I had <shameless plug> suggested an hour or two ago a scheme where the
> current development model be based off, but periodic releases be made
> "stable," basing on approximately 6 months between releases </shameless
> plug>.  I think it's a bit more sane to say that a maintainer may mount
> up 4 kernels in 2 years to backport bugfixes into, if nobody else steps
> up to the plate to help.
> 
> Of course, eventually official support has to be dropped in either
> scheme, because the same problem is faced:  We can't expect people to
> maintain a continuously mounting number of kernel revisions once the
> workload becomes sufficiently high.  A balance must be made between
> dropping support for a non-volitile code base, and maintaining a support
> period sufficiently long.

Not sure I get your point.
Again,
-ac is almost what I'm suggesting but I'd prefer to change it's name
and formalize it publishing the .Y patchset to kernel,org with a name
useful for the users.

Time to sleep now,
I'll flight to Germany tomorrow so I'll be offline till Tuesday. 
But hey, you don't need me anymore ;-)

-- 
Paolo
