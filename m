Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbSK2XZy>; Fri, 29 Nov 2002 18:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbSK2XZy>; Fri, 29 Nov 2002 18:25:54 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:23217 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267180AbSK2XZy>;
	Fri, 29 Nov 2002 18:25:54 -0500
Message-ID: <3DE7F939.3000608@colorfullife.com>
Date: Sat, 30 Nov 2002 00:33:13 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Georg Nikodym <georgn@somanetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: v2.4.19-rmk4 slab.c: /proc/slabinfo uses broken instead of slab
 labels
References: <3DE699EC.9060600@colorfullife.com> <20021128224028.F27234@flint.arm.linux.org.uk> <3DE7B0C2.7050301@colorfullife.com> <20021129225152.C4496@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>Gah, I _really_ wish that we had a method to notify architecture maintainers
>when this type of stuff changes.  Are we supposed to re-read the x86
>implementation of everything for each kernel release to try to discover
>what subtle semantics have changed?
>
>  
>
There was no change - i386 just permits something that doesn't work on 
all archs.



