Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283773AbRK3UIC>; Fri, 30 Nov 2001 15:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283777AbRK3UHw>; Fri, 30 Nov 2001 15:07:52 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:41604 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S283773AbRK3UHn>; Fri, 30 Nov 2001 15:07:43 -0500
Message-ID: <3C07E6D3.89A648AB@randomlogic.com>
Date: Fri, 30 Nov 2001 12:06:43 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>,
        "kplug-lpsg@kernel-panic.org" <kplug-lpsg@kernel-panic.org>
Subject: Re: Coding style - a non-issue
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <3C07CCCD.EA5E340A@randomlogic.com> <3C07D669.6C234598@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> 
> We could definitely use a ton more comments... patches accepted.
> 

I've actually thought of doing just that. :)

Alas, I'm too busy coding other things right now, so kernel stuff
(unless I need something to make the other project I'm working on
work/work better) will just have to wait. Hell, I'm even behind 2 or 3
kernel versions on the documentation I've been putting on my web site.
:(

> >  - Opening curly braces at the end of a the first line of a large code
> > block making it extremely difficult to find where the code block begins
> > or ends.
> 
> use a decent editor

A person shouldn't _need_ a decent editor to pick out the beginning/end
of a code block (or anything else for that matter). The problem is
exacerbated when such a block contains other blocks and quickly picking
out where each begins/ends becomes tiresome. I _do_ have excellent
editors, IDEs, and source code browsers and have used many different
kinds in many different jobs. They still can not replace what the human
eye and mind perceive.

> 
> >  - Short variable/function names that someone thinks is descriptive but
> > really isn't.
> 
> not all variable names need their purpose obvious to complete newbies.
> sometimes it takes time to understand the code's purpose, in which case
> the variable names become incredibly descriptive.

It should not take "time" to discover the purpose of _any_ variable or
function, or file, whether newbie or not. The point of coding is to
solve a problem, not perform an excersise in deductive or logical
reasoning before the problem (which usually involves further logical
reasoning) can be solved.

PGA
-- 
Paul G. Allen
UNIX Admin II ('til Dec. 3)/FlUnKy At LaRgE (forever!)
Akamai Technologies, Inc.
www.akamai.com
