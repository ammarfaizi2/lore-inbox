Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbVJCSJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVJCSJB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVJCSJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:09:00 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:18597 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932490AbVJCSI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:08:59 -0400
Date: Mon, 3 Oct 2005 14:08:58 -0400
To: Meelis Roos <mroos@linux.ee>
Cc: lkcl@lkcl.net, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051003180858.GA8011@csclub.uwaterloo.ca>
References: <20051003004442.GL6290@lkcl.net> <20051003075000.28A8C13ED9@rhn.tartu-labor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003075000.28A8C13ED9@rhn.tartu-labor>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 10:50:00AM +0300, Meelis Roos wrote:
> LKCL>  the code for oskit has been available for some years, now,
> LKCL>  and is regularly maintained.  the l4linux people have had to
> 
> My experience with oskit (trying to let students use it for OS course
> homework) is quite ... underwhelming. It works as long as you try to use
> it exactly like the developers did and breaks on a slightest sidestep
> from that road. And there's not much documentation so it's hard to learn
> where that road might be.
> 
> Switched to Linux/BSD code hacking with students, the code that actually
> works.

Can oskit be worse than nachos where the OS ran outside the memory space
and cpu with only applications being inside the emulated mips processor?
Made some things much too easy to do, and other things much to hard
(like converting an address from user space to kernel space an accessing
it, which should be easy, but was hard).

I suspect most 'simple' OS teaching tools are awful.  Of course writing
a complete OS from scratch is a serious pain and makes debuging much
harder than if you can do your work on top of a working OS that can
print debug messages.

Len Sorensen
