Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132465AbRDUDJc>; Fri, 20 Apr 2001 23:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132468AbRDUDJW>; Fri, 20 Apr 2001 23:09:22 -0400
Received: from smtp.mountain.net ([198.77.1.35]:54283 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S132465AbRDUDJE>;
	Fri, 20 Apr 2001 23:09:04 -0400
Message-ID: <3AE0F999.BA288768@mountain.net>
Date: Fri, 20 Apr 2001 23:08:09 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone 
 paying attention?
In-Reply-To: <20010420085148.V13403@opus.bloom.county> <Pine.LNX.4.33.0104201206250.12186-100000@xanadu.home> <20010420125005.B8086@thyrsus.com> <20010420200859.B5510@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: trimmed]

Russell King wrote:
> 
[...]
> 
> Generally it seems like diff needs to produce one more line of context, and
> most of these problems will go away.  Yes, there will still be the odd
> problem, so then it becomes the "how much do you crank the setting" problem.
>
 
$ diff -6 ...
will give 6 lines of context. patch will understand the output without any
extra help.

Cheers,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
