Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRCSGvo>; Mon, 19 Mar 2001 01:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRCSGve>; Mon, 19 Mar 2001 01:51:34 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:37906 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129292AbRCSGvZ>;
	Mon, 19 Mar 2001 01:51:25 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103190650.f2J6o1S240830@saturn.cs.uml.edu>
Subject: Re: [PATCH] Improved version reporting
To: rhw@MemAlpha.CX (Riley Williams)
Date: Mon, 19 Mar 2001 01:50:01 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), Andries.Brouwer@cwi.nl,
        viro@math.psu.edu, linux-kernel@vger.kernel.org (Linux Kernel),
        seberino@spawar.navy.mil
In-Reply-To: <Pine.LNX.4.30.0103171718530.22673-100000@infradead.org> from "Riley Williams" at Mar 17, 2001 05:51:28 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams writes:

>> The rule should be like this:
>>
>>	List the lowest version number required to get
>>	2.2.xx-level features while running a 2.4.xx kernel.
>
> That's a meaningless definition, and can only be taken as such. What
> use would such a list be to somebody wishing (like I recently was) to
> upgrade a system running the 2.0.12 kernel so it runs the 2.4.2
> kernel instead?
...
>> Basically I ask: would existing scripts for a 2.2.xx kernel
>> break? If the old mount can still do what it used to do, then
>> "mount" need not be listed at all.
>
> Replace that "a 2.2.xx" with "my current" and remove all restrictions
> on what the current kernel is, and that becomes an important question.

No, not "my current" but "the previous stable". I say "2.2.xx" because
that is the previous stable kernel.

If you upgrade from 2.0.xx, you should read the 2.2.xx changes file.

The important thing is to avoid version number inflation. I don't
even bother reading the changes file, because I know it is bogus.
Nearly all of my old software works great with a 2.4.xx kernel.
