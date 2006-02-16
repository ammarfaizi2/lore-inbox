Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWBRM54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWBRM54 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWBRMzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:55:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27547 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751217AbWBRMzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:55:06 -0500
Date: Thu, 16 Feb 2006 22:32:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <nigel@suspend2.net>,
       suspend2-devel@lists.suspend2.net, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060216213250.GE3490@openzaurus.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060209233406.GD3389@elf.ucw.cz> <200602101008.32368.nigel@suspend2.net> <200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz> <70FB74EB-5503-432D-8749-FD5A6807C23C@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70FB74EB-5503-432D-8749-FD5A6807C23C@mac.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Anyway, it means that suspend is still quite a hot topic, and that  
> >is good. (Linus said that suspend-to-disk is basically for people  
> >that can't get suspend-to-RAM to work, and after I got suspend-to- 
> >RAM to work reliably here, I can see his point).
> 
> I completely agree.  My Mac PowerBook has had suspend-to-RAM for a  
> long time; I shut the lid and about 3 seconds later it's asleep, open 
> it and 3 seconds later it's awake.  Leave it sleeping for a week on a 
> full charge, come back to find it still asleep.  I can even put it to 
> sleep, remove a drained battery and put in a fresh one (it has a  
> small internal 2-minute RAM battery), then wake it up and resume  
> work.  I'm curious though, what proportion of laptop hardware  
> actually has support for suspend-to-RAM?  (including hardware for  
> which linux does not yet have support).  What percent of that  
> hardware _does_ have Linux support?

99%+ of notebooks can do s-t-ram, and perhaps 50% desktops.
Linux should work on 70% or so...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

