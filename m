Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318862AbSHWPOU>; Fri, 23 Aug 2002 11:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318864AbSHWPOU>; Fri, 23 Aug 2002 11:14:20 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:48095 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S318862AbSHWPOT>; Fri, 23 Aug 2002 11:14:19 -0400
Date: Fri, 23 Aug 2002 10:18:23 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Greg Banks <gnb@alphalink.com.au>
cc: Roman Zippel <zippel@linux-m68k.org>,
       Peter Samuelson <peter@cadcamlab.org>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
In-Reply-To: <3D60BA16.38B9CC40@alphalink.com.au>
Message-ID: <Pine.LNX.4.44.0208231015540.22497-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2002, Greg Banks wrote:

> Roman Zippel wrote:
> > 
> > The problem here is one should consider, how all these little changes will
> > help to solve the big problems. Do they allow to more easily fix the big
> > problems or have these changes to be dumped again?
> 
> I believe fixing the existing rules within the existing syntax is an exercise
> worth doing, and that the results will carry across to whatever extended syntax/
> new language/new parsers/whatever will be the long-term solution.

Let me just second this. This doesn't mean to try random changes hoping 
that in the end the result is something sensible. But there are many cases 
which are obviously bugs or deficiences, and fixes / cleanups there are 
definitely a good idea as a first step.

--Kai



