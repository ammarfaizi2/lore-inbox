Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262213AbSJQWfR>; Thu, 17 Oct 2002 18:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262218AbSJQWfQ>; Thu, 17 Oct 2002 18:35:16 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:1038 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S262213AbSJQWfQ>; Thu, 17 Oct 2002 18:35:16 -0400
Date: Fri, 18 Oct 2002 08:39:00 +1000
From: john slee <indigoid@higherplane.net>
To: Daniel Phillips <phillips@arcor.de>
Cc: Padraig Brady <padraig.brady@corvil.com>, garrett@tbaytel.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE, TRIVIAL, RFC] Linux source strip/bundle script
Message-ID: <20021017223900.GP19055@higherplane.net>
References: <200210010734.14949.garrett@tbaytel.net> <3D998C95.9060606@corvil.com> <E17wQCI-0005v4-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17wQCI-0005v4-00@starship>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 06:48:34PM +0200, Daniel Phillips wrote:
> On Tuesday 01 October 2002 13:52, Padraig Brady wrote:
> > 3. What's the difference in size between 2.4.19.tar.bz2 and
> >     2.4.19-bastardized.tar.bz2 ?
> 
> Surely you meant "bowdlerized"?

nup, my understanding of that term is (in the cloak+dagger sense)
blacking out the sensitive bits with a big marker pen, typically before
showing them to people who shouldn't see the sensitive bits.

a quasi-sane way to do this bastardisation of the kernel sources would
be to do a make allyesconfig and remove anything that doesn't match up.
but given the amount of kernel source dedicated to generic drivers or
subsystems on any arch i think its a total waste of time, and i'm not
alone :-)

j.

-- 
toyota power: http://indigoid.net/
