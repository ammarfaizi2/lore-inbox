Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132886AbRA0XJu>; Sat, 27 Jan 2001 18:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132790AbRA0XJk>; Sat, 27 Jan 2001 18:09:40 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:14723 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132779AbRA0XJ3>; Sat, 27 Jan 2001 18:09:29 -0500
Date: Sat, 27 Jan 2001 23:09:27 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: David Schwartz <davids@webmaster.com>
cc: Gregory Maxwell <greg@linuxpower.cx>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: RE: hotmail not dealing with ECN
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKCECMNFAA.davids@webmaster.com>
Message-ID: <Pine.SOL.4.21.0101272308030.701-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001, David Schwartz wrote:

> 
> > Firewalling should be implemented on the hosts, perhaps with centralized
> > policy management. In such a situation, there would be no reason to filter
> > on funny IP options.
> 
> 	That's madness. If you have to implement your firewalling on every host,
> what do you do when someone wants to run a new OS? Forbid it?

Of course. Then you find out about some new problem you want to block, so
you spend the next week reconfiguring a dozen different OS firewalling
systems. Hrm... I'll stick with a proper firewall, TYVM!


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
