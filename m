Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWF3MYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWF3MYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWF3MYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:24:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33703 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932221AbWF3MYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:24:36 -0400
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <20060630014050.GI19712@stusta.de>
References: <20060629192121.GC19712@stusta.de>
	 <1151628246.22380.58.camel@mindpipe>
	 <20060629180706.64a58f95.akpm@osdl.org>  <20060630014050.GI19712@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Jun 2006 13:39:19 +0100
Message-Id: <1151671159.31392.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 03:40 +0200, ysgrifennodd Adrian Bunk:
> > I am stolidly letting the arch maintainers and the developer of this
> > feature work out what to do.
> 
> Andrea is proud of getting a patent for the server part [1], so I doubt 
> he would be happy with no longer having the client part defaulting to Y...

If Andrea has clear personal business interests in that decision then
perhaps you could make the case he shouldn't make the decision as to
whether it should be Y or not, or that someone should review it. No big
deal. There are lots of uses for that code. None of them appear
interesting 8)

I don't think its actually important because distributions make their
own decisions about such questions and most of the running kernels are
distribution ones. 

As to patented code for the kernel. That itself is a non-issue providing
the patent owner or someone with permission from them submitted the
code. The law recognizes that you cannot go around making promises
(estoppel) and then trying to sue people for acting on them. The GPL
likewise makes this clear.

> It might sound a bit strange that although Alan Cox and Linus Torvalds 
> even wrote an open letter to the President of the European Parliament
> calling "Software patents are also the utmost threat to the development 
> of Linux and other free software products" [2]...

The Red Hat position on patents is on the web site, along with the
permissions for GPL use. It makes clear the view we have on patents for
software.

Alan

