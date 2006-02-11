Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWBKIyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWBKIyK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 03:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWBKIyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 03:54:10 -0500
Received: from smtpout.mac.com ([17.250.248.87]:17384 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751236AbWBKIyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 03:54:09 -0500
In-Reply-To: <20060210233507.GC1952@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060209233406.GD3389@elf.ucw.cz> <200602101008.32368.nigel@suspend2.net> <200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <70FB74EB-5503-432D-8749-FD5A6807C23C@mac.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nigel Cunningham <nigel@suspend2.net>,
       suspend2-devel@lists.suspend2.net, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sat, 11 Feb 2006 03:53:30 -0500
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10, 2006, at 18:35, Pavel Machek wrote:
> Anyway, it means that suspend is still quite a hot topic, and that  
> is good. (Linus said that suspend-to-disk is basically for people  
> that can't get suspend-to-RAM to work, and after I got suspend-to- 
> RAM to work reliably here, I can see his point).

I completely agree.  My Mac PowerBook has had suspend-to-RAM for a  
long time; I shut the lid and about 3 seconds later it's asleep, open  
it and 3 seconds later it's awake.  Leave it sleeping for a week on a  
full charge, come back to find it still asleep.  I can even put it to  
sleep, remove a drained battery and put in a fresh one (it has a  
small internal 2-minute RAM battery), then wake it up and resume  
work.  I'm curious though, what proportion of laptop hardware  
actually has support for suspend-to-RAM?  (including hardware for  
which linux does not yet have support).  What percent of that  
hardware _does_ have Linux support?

Cheers,
Kyle Moffett

--
If you don't believe that a case based on [nothing] could potentially  
drag on in court for _years_, then you have no business playing with  
the legal system at all.
   -- Rob Landley



