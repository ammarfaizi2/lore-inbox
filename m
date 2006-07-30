Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWG3Oe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWG3Oe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 10:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWG3Oe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 10:34:57 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:57477 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750847AbWG3Oe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 10:34:56 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: suspend2 merge history [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Date: Sun, 30 Jul 2006 16:34:11 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44C42B92.40507@xfs.org> <200607292319.31935.rjw@sisk.pl> <44CCACC9.7090702@tmr.com>
In-Reply-To: <44CCACC9.7090702@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301634.11354.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 14:57, Bill Davidsen wrote:
> Rafael J. Wysocki wrote:
> 
> >On Saturday 29 July 2006 21:23, Bill Davidsen wrote:
> >  
> >
> >>Pavel Machek wrote:
> >>    
> >>
> >>>On Fri 28-07-06 01:22:49, Olivier Galibert wrote:
> >>>      
> >>>
> >>>>On Thu, Jul 27, 2006 at 11:42:25PM +0200, Pavel Machek wrote:
> >>>>        
> >>>>
> >>>>>So we have 1 submission for review in 11/2004 and 1 submission for -mm
> >>>>>merge in 2006, right?
> >>>>>          
> >>>>>
> >>>>Wrong.  I gave a list of dates at the beginning of the month, do you
> >>>>think I threw dice to get them?
> >>>>
> >>>>And could you explain, as suspend maintainer for the linux kernel, how
> >>>>come code submitted for the first time two years ago and with a much
> >>>>better track record than the in-kernel one is still not in?
> >>>>        
> >>>>
> >>>Because Nigel has too much of code to start with, and refuses to fix
> >>>his design because it would invalidate all the stabilization work.
> >>>      
> >>>
> >>Why should he invalidate his stabilization work, and what's in need of 
> >>fixing? The suspend in the kernel is great, but suspend2 includes both 
> >>suspend and working resume code as well.
> >>    
> >>
> >>>Plus Nigel did not do very good job with submitting those patches.
> >>>      
> >>>
> >>They apply, they work. What's not very good about that? Is this being 
> >>blocked because of a spelling error, or did he mess up the indenting on 
> >>"signed off by" or what? I realize you may have something other than the 
> >>download version, but it's been years now.
> >>
> >>I would like to see the working suspend (suspend2) in the kernel, and 
> >>users wanting to debug the resume stuff currently in the kernel could 
> >>get it under EXPERIMENTAL or some such.
> >>
> >You probably don't realize how offensive this is.
> >
> >Actually some people have been working really hard to make the in-kernel
> >code work and you could just respect that.
> >
> By respect I take it you mean "don't call attention to the fact that it 
> doesn't work for many people?"

Sorry, you won't get anywhere by insulting people.  If you want to call
attention to a problem, please file a bug report.

Greetings,
Rafael
