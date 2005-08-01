Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVHAVtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVHAVtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVHAVNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:13:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50933 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261252AbVHAVKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:10:45 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050801205208.GA20731@elte.hu>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <20050801205208.GA20731@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Mon, 01 Aug 2005 14:09:41 -0700
Message-Id: <1122930581.4623.10.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 22:52 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Ingo,
> > 
> > What's with the "BUG: possible soft lockup detected on CPU..."? I'm 
> > getting a bunch of them from the IDE interrupt.  It's not locking up, 
> > but it does things that probably do take some time.  Is this really 
> > necessary? Here's an example dump:
> 
> doh - it's Daniel not Cc:-ing lkml when sending me patches, so people 
> dont know what's going on ...
> 
> here's the patch below. Could you try to revert it?

You guys want me to always CC in the future? 

Daniel

