Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWEEANf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWEEANf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 20:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWEEANf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 20:13:35 -0400
Received: from animx.eu.org ([216.98.75.249]:27049 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S932405AbWEEANf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 20:13:35 -0400
Date: Thu, 4 May 2006 20:20:09 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrom: a dirty CD can freeze your system
Message-ID: <20060505002009.GA24014@animx.eu.org>
Mail-Followup-To: Joshua Hudson <joshudson@gmail.com>,
	linux-kernel@vger.kernel.org
References: <200605041232.k44CWnFn004411@wildsau.enemy.org> <1146750532.20677.38.camel@localhost.localdomain> <20060504165055.GA22880@animx.eu.org> <1146762658.22308.11.camel@localhost.localdomain> <bda6d13a0605041027kc0edb02icdd11bd103478b05@mail.gmail.com> <20060504204708.GC22880@animx.eu.org> <bda6d13a0605041710v480b4c0ci999fcf4b0cffa1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda6d13a0605041710v480b4c0ci999fcf4b0cffa1b@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson wrote:
> On 5/4/06, Wakko Warner <wakko@animx.eu.org> wrote:
> >Joshua Hudson wrote:
> >> I've seen this a few times. It never actually hung my system, only one
> >> virtual console. I wonder if preemptable kernel had something to do
> >> with that <g>
> >
> >I don't believe pre-empt has anything to do eith it.  I have a specialized
> >boot system (vairous types of boot media) w/o preempt turned on because I
> >want this as small as possible.  It also has this problem.
> 
> Uuhhh. I though preempt might be the reason the who system *wasn't* hanging.

One of those "didn't read the whole message" errors.  Oops.  All of my
systems (not the speciallized one) are preemptable.  I have not noticed any
lockups on those.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
