Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTDXVnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTDXVns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:43:48 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:60802 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261334AbTDXVna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:43:30 -0400
Date: Thu, 24 Apr 2003 17:41:07 -0400
From: Ben Collins <bcollins@debian.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030424214107.GH808@phunnypharm.org>
References: <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva> <Pine.LNX.3.96.1030424173619.11734F-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030424173619.11734F-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 05:44:39PM -0400, Bill Davidsen wrote:
> On Wed, 23 Apr 2003, Marcelo Tosatti wrote:
> 
> > I guess Ben's mega patch (and yes, I also consider it a megapatch for
> > -rc) has to be applied. I just mailed him asking about the possibility
> > of getting only fixes in and not the cleanups, but I guess that might be a
> > bit hard to do _today_. Right Ben ?
> > 
> > And about the sweet complaints about -pre timing, I will release -pre's
> > each damn week for .22.
> > 
> > *!@#!&*.
> 
> If I might offer a course of action, if you put thing which are *fixes* in
> the bk releases, and hold *changes* for the next -pre, it might allow
> people to grab bk's to fix the quickly caught things in a new pre, without
> being hit with major changes which might decrease stability.
> 
> Clearly any pre is a risk, but there always seem to be errors of the "XXX
> doesn't compile because of typo" type. That way Alan could put all new IDE
> code in each -pre and Andre and others could put fixes in the bk's until
> it worked. => JOKING!! <== but you get the idea.
> 
> I'd love to see this in 2.5 as well, just to encourage people to use it!

You do realize that the -pre's are pulled from bk, right?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
