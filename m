Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWA2NBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWA2NBF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 08:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWA2NBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 08:01:05 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:5065 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750952AbWA2NBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 08:01:04 -0500
Date: Sun, 29 Jan 2006 14:01:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@novell.com>
Cc: Paul Jackson <pj@sgi.com>, rml@ximian.com, akpm@osdl.org, steiner@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-ID: <20060129130142.GA20386@elte.hu>
References: <20060127230659.GA4752@sgi.com> <20060127191400.aacb8539.pj@sgi.com> <20060128133244.GA22704@elte.hu> <20060128120946.648bcf6a.pj@sgi.com> <1138481423.32314.35.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138481423.32314.35.camel@phantasy>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Robert Love <rml@novell.com> wrote:

> On Sat, 2006-01-28 at 12:09 -0800, Paul Jackson wrote:
> 
> > And here I've been blaming Robert for that syscall all these years.
> > 
> > My humble apologies, Robert ;).
> 
> Well, I actually did do the 2.5 version of the patch and sent it to 
> Linus, so I do find myself at confession on a monthly basis, begging 
> for some forgiveness.

ah, indeed, so *you* are the one to be blamed for passing on a mortally 
flawed hack, making you guilty of contributory enkludgement of the 2.6 
kernel ;)

	Ingo
