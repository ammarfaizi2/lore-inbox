Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135805AbRA1AMm>; Sat, 27 Jan 2001 19:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135845AbRA1AMV>; Sat, 27 Jan 2001 19:12:21 -0500
Received: from [63.95.87.168] ([63.95.87.168]:57863 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S135782AbRA1AMA>;
	Sat, 27 Jan 2001 19:12:00 -0500
Date: Sat, 27 Jan 2001 19:11:59 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: James Sutherland <jas88@cam.ac.uk>
Cc: David Schwartz <davids@webmaster.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010127191159.B7467@xi.linuxpower.cx>
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKCECMNFAA.davids@webmaster.com> <Pine.SOL.4.21.0101272308030.701-100000@green.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <Pine.SOL.4.21.0101272308030.701-100000@green.csi.cam.ac.uk>; from jas88@cam.ac.uk on Sat, Jan 27, 2001 at 11:09:27PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2001 at 11:09:27PM +0000, James Sutherland wrote:
> On Sat, 27 Jan 2001, David Schwartz wrote:
> 
> > 
> > > Firewalling should be implemented on the hosts, perhaps with centralized
> > > policy management. In such a situation, there would be no reason to filter
> > > on funny IP options.
> > 
> > 	That's madness. If you have to implement your firewalling on every host,
> > what do you do when someone wants to run a new OS? Forbid it?
> 
> Of course. Then you find out about some new problem you want to block, so
> you spend the next week reconfiguring a dozen different OS firewalling
> systems. Hrm... I'll stick with a proper firewall, TYVM!

It's this kind of ignorance that makes the internet a less secure and stable
place.

The network should not be a stateful device. If you need stateful
firewalling the only place it should be implimented is on the end node. If
management of that is a problem, then make an interface solve that problem
insted of breaking the damn network.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
