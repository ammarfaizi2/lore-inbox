Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268667AbUH3RbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268667AbUH3RbW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268654AbUH3Rav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:30:51 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:32233 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S268648AbUH3RaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:30:11 -0400
Date: Mon, 30 Aug 2004 10:31:57 -0700
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Summarizing the PWC driver questions/answers
Message-ID: <20040830173157.GA24392@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <20040827162613.GB32244@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827162613.GB32244@kroah.com>
X-No-Archive: yes
X-Noarchive: yes
User-Agent: Mutt/1.5.6i
From: Brian Litzinger <brian@worldcontrol.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 09:26:13AM -0700, Greg KH wrote:
> Q: Why did you remove the hook from the pwc driver?
> A: It was there for the explicit purpose to support a binary only
>    module.  That goes against the kernel's documented procedures, so I
>    had to take it out.

I think Greg "chose" to take it out.

> Q: That hook had been in there for years!  Why did you suddenly decide
>    to remove it now?
> A: I was really not aware of the hook, and the fact that it was only
>    good for a binary module to use.  I'm sorry, I should have realized
>    this years ago, but I didn't.  Recently someone pointed this hook out
>    to me, and the fact that it really didn't belong in there due to the
>    kernel's policy of such hooks.  So, once I became aware of it, I had
>    no choice but to remove it.

I do not believe he "had no choice".  The guards at Auswitchs made the
same argument at Nuremberg.  The tribunal determined they did have a
choice.  I doubt we can consider the conditions here more extreme
then there.

> Q: But you took away my freedom!  Isn't Linux about freedom?
> A: Again, it was Nemosoft's decision.  The kernel also has to abide by
>    it's documented procedures, so that is why the hook had to go.

The kernel cannot act itself.  It is more or less an inanimate
object.  People must carry out actions on its behalf.

> Q: You jerk, I had invested lots of money in this camera, you are
>    costing me money by ripping it out.  You should be ashamed of
>    yourself!
> A: See the above question about freedom.  If it means that much to you,
>    then offer to maintain the code, it's that simple.

This confuses me.  The functionability people are after is the closed
source part. Maintaining the open source portion seems unrelated.

> Q: You are keeping companies from wanting to write binary drivers for
>    Linux.
> A: Duh!  What do you think all of the kernel developers have been
>    stating for years, in public.  Binary drivers only take from Linux,
>    they do not give back anything.  See Andrew Morton's OLS 2004 keynote
>    address for more information and background on this topic.

I disagree.  Binary drivers may take away from Linux and they may add to it.

> Q: You are a fundamentalist turd / jerk / pompous ass /
>    GNU-freebeer-biased-idiot-fundamentalist fucktard / ignorant slut!
> A: I've been called worse by better people, get over yourself.

I think from statements Greg made above we can at least say he is
willing to hide behind misplaced authority.

-- 
Brian Litzinger
