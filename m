Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161180AbVKRUcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbVKRUcB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVKRUbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:31:48 -0500
Received: from kanga.kvack.org ([66.96.29.28]:48573 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1161178AbVKRUbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:31:37 -0500
Date: Fri, 18 Nov 2005 15:29:10 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Bharath Ramesh <krosswindz@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: intel8x0 sound of silence on dell system
Message-ID: <20051118202910.GD22566@kvack.org>
References: <20051118162300.GA22092@kvack.org> <c775eb9b0511180959r12206562h5a294d9505d95d04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c775eb9b0511180959r12206562h5a294d9505d95d04@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, but it isn't muted.  I'm not a newbie. ;-)

		-ben

On Fri, Nov 18, 2005 at 12:59:28PM -0500, Bharath Ramesh wrote:
> Probably the sound car is muted. you might want to try out the
> alsamixer to unmute the card.
> 
> On 11/18/05, Benjamin LaHaise <bcrl@kvack.org> wrote:
> > Hello all,
> >
> > On trying out head on my workstation, it seems that no sound comes out.
> > The module is getting loaded and the interrupts line for the 'Intel ICH5'
> > is increasing.  The RHEL 4 kernel is known to work on this machine.  The
> > only output from the driver is below.  Any ideas?
> >
> >                 -ben
> >
> > intel8x0_measure_ac97_clock: measured 51314 usecs
> > intel8x0: clocking to 48000
> > --
> > "Time is what keeps everything from happening all at once." -- John Wheeler
> > Don't Email: <dont@kvack.org>.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
Don't Email: <dont@kvack.org>.
