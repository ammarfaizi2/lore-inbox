Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUG1UVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUG1UVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUG1UVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:21:21 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:65297 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S263147AbUG1UVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:21:19 -0400
Date: Wed, 28 Jul 2004 13:21:07 -0700
To: Lee Revell <rlrevell@joe-job.com>
Cc: karim@opersys.com, Scott Wood <scott@timesys.com>,
       Ingo Molnar <mingo@elte.hu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>,
       Philippe Gerum <rpm@xenomai.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IRQ threads
Message-ID: <20040728202107.GA6952@nietzsche.lynx.com>
References: <20040727225040.GA4370@yoda.timesys> <4107CA18.4060204@opersys.com> <1091039327.747.26.camel@mindpipe> <4107FA93.3030801@opersys.com> <1091043218.766.10.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091043218.766.10.camel@mindpipe>
User-Agent: Mutt/1.5.6+20040722i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 03:33:38PM -0400, Lee Revell wrote:
> I am familiar with Adeos, as well as other hard-RT solutions for Linux. 
> I did my homework before deciding that I do not in fact need hard-RT, so
> I really am not interested in your flamewars, keep them on your RT
> mailing lists.
> 
> The part that was obvious commercially motivated FUD (and which you
> omitted) t in which you badmouth TimeSys and its services, then  Your
> .sig states that you are a consultant specializing in realtime and
> embedded Linux.

With that said, there's really two camps that are emerging in the real
time Linux field, dual and single kernel. The single kernel work that's
current being done could very well get Linux to being hard RT, assuming
that you solve all of the technical problems with things like RCU,
etc... in 2.6.

The dual kernels folks would be in less of position to VAR their own
stuff and sell proprietary products if Linux were to get native hard RT
performance if you accept that economic criteria. Who knows what the
actual results will be.

It could be that all of this work with Linux could bury prioprietary
OS product (such as LynxOS here) or it could open doors to other things
unknown things that were never possible previous to Linux getting some
kind of hard RT capability. It's certainly a scary notion to think about
with many variables to consider. Linux getting hard RT is inevitable.
It's just a question of how it'll be handled by proprietary OS vendors,
witness IBM for a positive example. A negative one would be Sun.

Now that Windriver System (the idiot folks that never understood Linux
before laying off tons of folks and disbanned the rather famous BSD/OS
group which I was apart of, etc...) and Red Hat is in the picture, it's
all starting to cook up.

All things to think about.

bill

