Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265870AbTGSPTj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 11:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270049AbTGSPTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 11:19:39 -0400
Received: from adedition.com ([216.209.85.42]:58117 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S265870AbTGSPTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 11:19:37 -0400
Date: Sat, 19 Jul 2003 11:34:23 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper
Message-ID: <20030719153423.GA17587@mark.mielke.cc>
References: <E19dbGS-00026T-9R@fencepost.gnu.org> <1058558982.2479.28.camel@aurora.localdomain> <20030718221730.GF2289@matchmail.com> <1058567990.19512.103.camel@dhcp22.swansea.linux.org.uk> <m1lluvx700.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1lluvx700.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 02:20:31AM -0600, Eric W. Biederman wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > > I don't think Alan is using BK.  I could be wrong though.
> > I'm not - and with the snapshots neither I or anyone else is forced to.
> For the linux kernel.  The problem is the satellite projects which
> adopt bitkeeper less carefully.  Unless there is a general gateway I
> have missed.

They do not provide snapshots?

As long as tar files are distributed for each minor release, there is no
true 'lock in'. If you need a gateway for a specific satellite project,
there are people that could probably hook you up with the software required,
and if there are other people in your situation, one of them probably has
enough CPU + network + disk resources to host it.

The Bit Keeper issue is entirely a philosophical one. I understand
that Linus chooses to use it, because it allows him to be more
efficient. Alan Cox chooses not to use it (I'm not clear on his
reasons, but I assume they are just as good). What more proof do we
need that Bit Keeper is not locking people in?

I don't use it, and have never used it at this point, primarily
because I happen to be in the source management field currently, and I
have chosen to respect Larry's license. I'm certain that if I ever had
a proper need in terms of kernel development, the license could be
waived or altered on a case-by-case basis.

Stallman puts himself 100% in the philosopher's chair. He seems to believe
that any variation or compromise weakens his overall position. Every few
months he starts a flame war just to satisfy his own guilt that rises from
him feeling that he isn't doing enough to 'promote' free projects, even if
the free projects don't exist yet, or are not as feature-full.

A few of us have a real love-hate relationship with Stallman. We love what he
has accomplished. We hate how he accomplishes his goals.

The bottom line of all of this, is that Stallman is preaching to the wrong
people. He should stick to press releases and such. Kernel developers just
want to get work done. Any investment into writing a new source management
system would be better served by improving the linux source code. If this
wasn't so, the kernel developers wouldn't be kernel developers. They would
be like me... source management developers... :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

