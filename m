Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276642AbRJKRyH>; Thu, 11 Oct 2001 13:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276633AbRJKRx6>; Thu, 11 Oct 2001 13:53:58 -0400
Received: from suphys.physics.usyd.edu.au ([129.78.129.1]:20701 "EHLO
	suphys.physics.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S276642AbRJKRxt>; Thu, 11 Oct 2001 13:53:49 -0400
Date: Fri, 12 Oct 2001 03:52:59 +1000 (EST)
From: Tim Connors <tcon@Physics.usyd.edu.au>
To: jkp@riker.nailed.org
cc: linux-kernel@vger.kernel.org
Subject: Re: Which kernel (Linus or ac)?
In-Reply-To: <XFMail.20011011094548.jkp@riker.nailed.org>
Message-ID: <Pine.SOL.3.96.1011012034648.5285B-100000@suphys.physics.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001 jkp@riker.nailed.org wrote:

> I'm presently running 2.4.8 on a machine. The VM on this is not terribly
> good (swaps a lot with seemlingly plenty of physical memory).
> I'm considering going to an -ac kernel, but I need recent iptables. Is the
> iptables code up to date in -ac?

Seems to be, how recent do you want? I am using it, anyways....

> Also, which -ac do people recommend? I've beent trying to follow lkm, but
> I'm somewhat confused at this point.

-ac is much better than -linus for me.

I am using 2.4.9-ac18. It is mostly good, the occasion swapping when I
leave mozilla or xemacs alone for a little while, but mostly good. Much
better than ever since 2.4.~5 though!

Used 2.4.10-ac1 for a while, but seems worse than 2.4.9-ac1[678].

Looking at the changelog and comments on the list and /. though - very
very promising with 2.4.10-ac11 with the new VM changes. I will compile
that one tonight and try it out when I next reboot (finally having a
decent kernel has given me some uptime I don't want to destroy though ;)

> The box:
> 
> P200MMX 64MB
> 
> It's used as a firewall and a ssh login/through server for external connections.

2.4.9-ac* should be good for such a box - looks like you don't put much
demand on it (although the RAM is a little small....)

-- 
TimC -- http://www.physics.usyd.edu.au/~tcon/

"I give up," said Pierre de Fermat's friend. "How DO you keep a
mathematician busy for 350 years?"

