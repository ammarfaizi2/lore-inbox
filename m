Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbRFYV3Q>; Mon, 25 Jun 2001 17:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262058AbRFYV3G>; Mon, 25 Jun 2001 17:29:06 -0400
Received: from force.4t2.com ([195.230.37.100]:7192 "EHLO force.4t2.com")
	by vger.kernel.org with ESMTP id <S261651AbRFYV2y>;
	Mon, 25 Jun 2001 17:28:54 -0400
Date: Mon, 25 Jun 2001 23:13:57 +0200
From: Thomas Weber <x@abyss.4t2.com>
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.6pre iptables masquerading seems to kill eth0
Message-ID: <20010625231357.A9560@4t2.com>
In-Reply-To: <3B31A652.85D2E597@idb.hist.no> <9gtmol$9ve$1@pandemonium.abyss.4t2.com> <3B32F1BA.C43BBE8A@idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B32F1BA.C43BBE8A@idb.hist.no>; from helgehaf@idb.hist.no on Fri, Jun 22, 2001 at 09:20:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2001 at 09:20:26AM +0200, Helge Hafting wrote:
> Thomas Weber wrote:
> > 
> > I'm on 2.4.6pre3 + freeswan/ipsec on my gateway now for 5 days.
> > It's an old 486/66 32MB with several isdn links, a dsl uplink (with
> > iptables masquerading) behind a ne2k clone and a 3c509 to the inside network.
> > no problems at all with the interfaces (all compiled as modules).
> 
> Nice to know it works for you.  The troubled machine is a dual celeron, 
> so it could be some sort of SMP problem.  I am trying pre5
> to see if it is better, I'll probably know in a few days.

since i just read another report on the list I checked again and it seems 
like i messed it up: 
you were talking about the 3c905, but I have a 3c509 (ISA) card.
I should have known, it's not the first time i mixed them up :(

  Tom
