Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288262AbSAMWx7>; Sun, 13 Jan 2002 17:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288266AbSAMWxu>; Sun, 13 Jan 2002 17:53:50 -0500
Received: from zero.tech9.net ([209.61.188.187]:30482 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288262AbSAMWxl>;
	Sun, 13 Jan 2002 17:53:41 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: jogi@planetzork.ping.de, Andrea Arcangeli <andrea@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Rob Landley <landley@trommello.org>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16PtX0-0000VA-00@starship.berlin>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu>
	<20020112121315.B1482@inspiron.school.suse.de>
	<20020112160714.A10847@planetzork.spacenet> 
	<E16PtX0-0000VA-00@starship.berlin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 13 Jan 2002 17:56:25 -0500
Message-Id: <1010962587.813.22.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-13 at 17:55, Daniel Phillips wrote:

> I'd like to add my 'me too' to those who have requested a re-run of this test, building
> the *identical* kernel tree every time, starting from the same initial conditions.
> Maybe that's what you did, but it's not clear from your post.

He later said he did in fact build the same tree, from the same initial
condition, in single user mode, etc etc ... sounded like good testing
methodology to me.

I later asked for a test of Ingo's sched with ll (to compare to Ingo's
sched with preempt).  In this test, like the others, preempt gives the
best times.

	Robert Love

