Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVJGLPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVJGLPI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVJGLPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:15:08 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12429 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751326AbVJGLPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:15:06 -0400
Date: Fri, 7 Oct 2005 13:15:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051007111544.GB857@elte.hu>
References: <1128458707.13057.68.camel@tglx.tec.linutronix.de> <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com> <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com> <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu> <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain> <20051006084920.GB22397@elte.hu> <Pine.LNX.4.58.0510061122530.418@localhost.localdomain> <Pine.LNX.4.58.0510070706100.6608@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510070706100.6608@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> I was compiling a kernel in a shell that I set to a priority of 20, 
> and it locked up on the bit_spin_lock crap of jbd.  Did you want me to 
> send you that patch again that adds another spinlock to the buffer 
> head and uses that instead of the bit_spins?

yeah, please do.

	Ingo
