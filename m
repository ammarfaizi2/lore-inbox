Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbUKCQju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbUKCQju (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbUKCQju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:39:50 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:52166 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261702AbUKCQiq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:38:46 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 11:38:45 -0500
User-Agent: KMail/1.7
Cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <20041103143348.GA24596@outpost.ds9a.nl> <yw1xis8nhtst.fsf@ford.inprovide.com>
In-Reply-To: <yw1xis8nhtst.fsf@ford.inprovide.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411031138.45095.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.46.51] at Wed, 3 Nov 2004 10:38:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 09:49, Måns Rullgård wrote:
>bert hubert <ahu@ds9a.nl> writes:
>> On Wed, Nov 03, 2004 at 07:51:39AM -0500, Gene Heskett wrote:
>>> But I'd tried to run gnomeradio earlier to listen to the
>>> elections,
>>
>> Depressing enough.
>>
>>> I'd tried to kill the zombie earlier but couldn't.
>>> Isn't there some way to clean up a &^$#^#@)_ zombie?
>>
>> Kill the parent, is the only (portable) way.
>
>Perhaps not as portable, but another possible, though slightly
>complicated, way is to ptrace the parent and force it to wait().

No deal.  No way.  The user needs something to clean up when he clicks 
on an icon, and things go to hell in a handbasket.  He has no advance 
warning available to him to tell him he had better ptrace this one 
that I'm aware of.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
