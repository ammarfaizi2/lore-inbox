Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWAPP4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWAPP4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 10:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWAPP4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 10:56:00 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:40937 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751080AbWAPPz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 10:55:59 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: Steven Rostedt <rostedt@goodmis.org>
To: tglx@linutronix.de
Cc: Lee Revell <rlrevell@joe-job.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       Roger Heflin <rheflin@atipa.com>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <1137405154.7634.74.camel@localhost.localdomain>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	 <1137168254.7241.32.camel@localhost.localdomain>
	 <1137174463.15108.4.camel@mindpipe>
	 <Pine.LNX.4.58.0601131252300.8806@gandalf.stny.rr.com>
	 <1137174848.15108.11.camel@mindpipe>
	 <Pine.LNX.4.58.0601131338370.6971@gandalf.stny.rr.com>
	 <1137178506.15108.38.camel@mindpipe>
	 <1137182991.8283.7.camel@localhost.localdomain>
	 <1137183980.6731.1.camel@localhost.localdomain>
	 <1137184982.15108.69.camel@mindpipe>
	 <1137185175.7634.37.camel@localhost.localdomain>
	 <1137186319.6731.6.camel@localhost.localdomain>
	 <1137186612.7634.41.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0601131616001.8385@gandalf.stny.rr.com>
	 <1137405154.7634.74.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 10:55:24 -0500
Message-Id: <1137426924.7150.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-16 at 10:52 +0100, Thomas Gleixner wrote:
> On Fri, 2006-01-13 at 16:17 -0500, Steven Rostedt wrote:
> > > >
> > > > Hmm, it doesn't compile :(
> > >
> > > Grmbl, I check this tomorrow. Getting late here
> > >
> > 
> > OK, I'll probably wont work on it till Monday then (wifes rules ;)
> 
> Can you try this one please ?
> 
> http://tglx.de/projects/hrtimers/2.6.15/patch-2.6.15-hrt3.patch

It compiled.

I'll boot into it now.

-- Steve

