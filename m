Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274826AbTGaQUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274827AbTGaQUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:20:37 -0400
Received: from www.13thfloor.at ([212.16.59.250]:2223 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S274826AbTGaQU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:20:29 -0400
Date: Thu, 31 Jul 2003 18:20:37 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Timothy Miller <miller@techsource.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <20030731162037.GB32759@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Timothy Miller <miller@techsource.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org> <Pine.LNX.4.53.0307291338260.6166@chaos> <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com> <20030730052213.GU150921@niksula.cs.hut.fi> <3F29296E.6000602@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3F29296E.6000602@techsource.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 10:36:30AM -0400, Timothy Miller wrote:
> 
> 
> Ville Herva wrote:
> >On Tue, Jul 29, 2003 at 08:17:15PM -0400, you [Zwane Mwaikambo] wrote:
> 
> >Most times when you need to have it fixed is when your box has mysteriously
> >locked up, and you'd wan't to know if there was a oops on the screen. No 
> >can
> >do - the console is already blanked. By then it is too late to fix it.
> >
> >In what cases is console blanking so hugely important these days, anyway?
> 
> 
> Why don't we borrow a trick from my old Atari 8-bit computer.  Instead 
> of blanking, cycle the colors.  Best of both worlds:  You save your 
> monitor AND you get to see what's on the screen.

hmm, ignoring the issue that modern monitors will not
suffer the burnin, how would it help to cycle the colors?
the only valid solution would be inverting the image on
a regular basis, and I don't think that this would be
appreciated ...

just my opinion,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
