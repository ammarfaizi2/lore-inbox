Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269865AbRHDVWk>; Sat, 4 Aug 2001 17:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269867AbRHDVWa>; Sat, 4 Aug 2001 17:22:30 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:60424 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S269865AbRHDVWU>;
	Sat, 4 Aug 2001 17:22:20 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108042122.f74LMR313894@saturn.cs.uml.edu>
Subject: Re: don't feed the trolls (was: intermediate summary of ext3-2.4-0.9.4 thread)
To: /dev/null@localhost.emma.line.org
Date: Sat, 4 Aug 2001 17:22:27 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <20010804053018.D16516@emma1.emma.line.org> from "Matthias Andree" at Aug 04, 2001 05:30:18 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree writes:
> On Fri, 03 Aug 2001, Albert D. Cahalan wrote:

>> This is just completely true. One wonders why we seem to enjoy
>> getting screwed this way. We shouldn't be patching these MTAs or
>> hacking Linux to act like BSD. We should be avoiding these MTAs.
>
> Oh, you should make a start avoiding any MTAs because that way, this
> list would get rid of one trouble maker after all.
>
> Don't feed the trolls.

That wasn't intended to be a troll, though I do realize that it
could cause some noise -- including your post. Plenty of noise is
already being generated trying to accommodate hostile MTA authors.

Seriously, consider:

1. there are MTA authors that actively promote BSD over Linux
2. Linux users and distributions promote their MTA software

There is no sense in this. It is masochism and suicide.
It is worse than a waste of time to accommodate these MTAs.

Getting back on topic... while non-inherited ext2 attributes might
be nice, I'm sure the ext2/VFS authors don't need to be pestered
about it, and certainly not because of some lame software making
non-standard assumptions about filesystem behavior.
