Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVBCCrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVBCCrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 21:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVBCCrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 21:47:33 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:26886 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262449AbVBCCrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 21:47:16 -0500
Date: Wed, 2 Feb 2005 18:46:50 -0800
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Bill Huey <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050203024650.GA15334@nietzsche.lynx.com>
References: <20050202213402.GB14023@nietzsche.lynx.com> <200502022259.j12Mxtau001972@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502022259.j12Mxtau001972@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 05:59:54PM -0500, Paul Davis wrote:
> Actually, JACK probably is the most sophisticated media *framework* on
> the planet, at least inasmuch as it connects ideas drawn from the
> media world and OS research/design into a coherent package. Its not
> perfect, and we've just started adding new data types to its
> capabilities (its actually relatively easy). But it is amazingly
> powerful in comparison to anything offered to data, and is
> unencumbered by the limitations that have affected other attempts to
> do what it does.

This is a bit off topic, but I'm interested in applications that are
more driven by time and has abstraction closer to that in a pure way.
A lot of audio kits tend to be overly about DSP and not about time.
This is difficult to explain, but what I'm referring to here is ideally
the next generation these applications and their design, not the current
lot. A lot more can be done.

> And it makes possible some of the most sophisticated *audio* apps on
> the planet, though admittedly not video and other data at this time.

Again, the notion of time based processing with broader uses and not
just DSP which what a lot of current graph driven audio frameworks
seem to still do at this time. Think gaming audio in 3d, etc...

I definitely have ideas on this subject and I'm going to hold my
current position on this matter in that we can collectively do much
better.

bill

