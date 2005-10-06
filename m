Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbVJFIgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVJFIgw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVJFIgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:36:52 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:9370 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750750AbVJFIgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:36:51 -0400
Date: Thu, 6 Oct 2005 10:37:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051006083727.GA22397@elte.hu>
References: <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com> <1128450029.13057.60.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com> <1128458707.13057.68.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com> <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com> <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu> <Pine.LNX.4.58.0510060425561.28535@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510060425561.28535@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> So I guess these patches need to go upstream too?
> 
> Here's the rest of the u32 coversions. Not all the u32 flags were used 
> for spinlocks. Most were for the flags instance in the structure.
> 
> Note, this patch does _NOT_ include the previous patch that I sent.  
> If this needs to go upstream, I'll send the two together as one patch.

(actually, it seems to include the previous patch too.)

	Ingo
