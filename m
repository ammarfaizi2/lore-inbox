Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVJFIo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVJFIo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVJFIo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:44:56 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:5331 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750735AbVJFIoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:44:55 -0400
Date: Thu, 6 Oct 2005 04:44:43 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <20051006083339.GA22224@elte.hu>
Message-ID: <Pine.LNX.4.58.0510060442090.28535@localhost.localdomain>
References: <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
 <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
 <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com>
 <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu>
 <Pine.LNX.4.58.0510060425561.28535@localhost.localdomain> <20051006083339.GA22224@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Oct 2005, Ingo Molnar wrote:

> >
> > Note, this patch does _NOT_ include the previous patch that I sent.
> > If this needs to go upstream, I'll send the two together as one patch.
>
> in any case i've applied both patches to the -rt tree.
>

Oops! I just noticed that the patch _did_ include the previous patch.
Sorry Ingo, you probably noticed when you applied the second patch.  I
did a find . '*.orig' to determine what to diff and forgot that I still
had the first patch .orig there.

:-}

Sorry,

-- Steve

