Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbTCPTWh>; Sun, 16 Mar 2003 14:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262748AbTCPTWh>; Sun, 16 Mar 2003 14:22:37 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:27405 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262747AbTCPTWf>; Sun, 16 Mar 2003 14:22:35 -0500
Date: Sun, 16 Mar 2003 20:33:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Nicolas Pitre <nico@cam.org>
cc: Andrea Arcangeli <andrea@suse.de>, Ben Collins <bcollins@debian.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
In-Reply-To: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home>
Message-ID: <Pine.LNX.4.44.0303162014090.12110-100000@serv>
References: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 16 Mar 2003, Nicolas Pitre wrote:

> > The missing bits are absolutely not worthless. They are very useful when 
> > you want to test other SCM system to simulate distributed development.
> 
> This is completely ridiculous.  Isn't this a bit too demanding?

Not really, it's actually more simple to what Larry is currently offering. 
A simply SCCS to RCS converter would be enough. Merging information is 
easy to add as well. If you now also add a sequence number is quite simple 
to modify a CVS server which can export the data reliably.

> Be realistic.  The missing bits are worthless and add absolutely no value to 
> kernel development which is supposed to be the topic for this mailing list.  

If you want to test an alternative system to see whether it's usable for 
kernel development, what better data is there? How could you compare it 
against bk?

bye, Roman

