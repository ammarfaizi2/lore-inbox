Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289621AbSAJT07>; Thu, 10 Jan 2002 14:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289655AbSAJT0n>; Thu, 10 Jan 2002 14:26:43 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17823 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289637AbSAJTZ7>;
	Thu, 10 Jan 2002 14:25:59 -0500
Date: Thu, 10 Jan 2002 19:26:52 +0100 (CET)
From: Cristiano Paris <c.paris@libero.it>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18pre2 oops using agpgart
In-Reply-To: <20020110110547.A4633@kittpeak.ece.umn.edu>
Message-ID: <Pine.LNX.4.33.0201101925080.27496-100000@gandalf.rhpk.springfield.inwind.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jan 10, 2002 at 05:44:17PM +0100, Cristiano Paris wrote:
> > It finally turned out that using the agpgart module with my notebook makes
> > my machine crash and reset. Here's the last oops :
>
> Hehehe you think this error is specific to agpgart?

No, I don't think so. IMHO, it seems a VM problem which badly interact
with the agpgart or at least doesn't work well with agpgart.

> I've seen very
> similar traces from SMP.  Even sent these specific tracebacks here,
> offered to help track down the problem, got 0 help.  This problem
> has been around since at least 2.4.2.

Thanks :-)

Cristiano

