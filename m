Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWJMVqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWJMVqO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWJMVqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:46:13 -0400
Received: from solarneutrino.net ([66.199.224.43]:43788 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932086AbWJMVqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:46:12 -0400
Date: Fri, 13 Oct 2006 17:46:08 -0400
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org,
       auke-jan.h.kok@intel.com
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
Message-ID: <20061013214608.GD19608@tau.solarneutrino.net>
References: <20061013214029.35732.qmail@web83103.mail.mud.yahoo.com> <20061013214250.GC19608@tau.solarneutrino.net> <20061013214523.GK3039@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061013214523.GK3039@mail.muni.cz>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 11:45:23PM +0200, Lukas Hejtmanek wrote:
> On Fri, Oct 13, 2006 at 05:42:50PM -0400, Ryan Richter wrote:
> > >   The similar issue has been discussed in adjacent thread "Machine
> > >   reboot". Is it Intel motherboard, or just carries Intel chipset ?
> > >   Does building e1000 driver as a module and 'rmmod e1000' just before
> > >   reboot help ?
> > 
> > It's an Intel DG965RY board.  I'll try out your suggestion on Monday.
> 
> Btw, are you using i386 or x86_64 architecture?

x86_64.

-ryan
