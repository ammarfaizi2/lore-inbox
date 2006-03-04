Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWCDVU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWCDVU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 16:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbWCDVU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 16:20:29 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:4357 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1752062AbWCDVU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 16:20:28 -0500
Date: Sat, 4 Mar 2006 22:20:15 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: psmith@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild: Problem with latest GNU make rc
Message-ID: <20060304212015.GA1539@mars.ravnborg.org>
References: <17417.42927.851653.114068@lemming.engeast.baynetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17417.42927.851653.114068@lemming.engeast.baynetworks.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 09:43:59AM -0500, psmith@gnu.org wrote:
> Hi all;
> 
> An incompatibility between kbuild and the latest GNU make 3.81 release
> candidate has been uncovered by Art Haas.  He reports that when building
> current kernels with the latest GNU make rc, everything will always be
> rebuilt every time.
> 
> 
> I've done an analysis of the issue and reported my findings on
> Wednesday, 1 March to the kbuild-devel mailing list (which, according to
> its archives, hasn't had any messages go through since 31 Jan--is anyone
> approving them anymore?) and to the bug-make mailing list (but a
> corruption in lists.gnu.org's TMDA database last week has caused a huge
> backlog which is only now being cleared).

mec modrate this list and he does so very timely - on leave I guess.

> For full details you can find an archived copy of my message here:
> 
>   http://lists.gnu.org/archive/html/bug-make/2006-03/msg00003.html
> 
> 
> The problem is that the new behavior is (I believe) correct.  If I'm
> right then this leaves us with a bit of a tricky situation to manage.
> 
> If anyone has an opinion or would like to discuss the situation, please
> follow up to my email on bug-make@gnu.org (I would prefer to hold the
> discussion there since I don't subscribe to linux-kernel).
I have the original somewhere - and I will bring the discussion on lkml.
lkml users as a general rule keeps cc:'s

	Sam
