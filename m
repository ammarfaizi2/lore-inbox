Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbUEWQBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUEWQBs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 12:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUEWQBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 12:01:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:31361 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263121AbUEWQBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 12:01:47 -0400
Date: Sun, 23 May 2004 09:01:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ian Stirling <ian.stirling@mauve.plus.com>
cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjanv@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
In-Reply-To: <40B0C56A.1050701@mauve.plus.com>
Message-ID: <Pine.LNX.4.58.0405230855250.25502@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org>
 <1085299337.2781.5.camel@laptop.fenrus.com> <20040523152540.GA5518@kroah.com>
 <40B0C56A.1050701@mauve.plus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 May 2004, Ian Stirling wrote:
> 
> Has anyone ever tried to forge the name on a patch, and get it included?

Not to my knowledge. It's a bit harder than just technically forging the
email, you also have to forge a certain "context", since most developers
know the "next hop" person anyway, and thus kind of know what to expect.  
You may not see the other person, but that doesn't mean that you can't
recognize his/her way of doing things.

And if you do _not_ know the person that the forged message comes in as,
then you have to check the patch anyway, so ...

That said, forged emails is not what this process would be about. Quite
frankly, I hope we'll some day have "trusted email", but that's kind of an
independent issue, in that I hope it moves in that direction _regardless_ 
of any patch documentation issues..

		Linus
