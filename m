Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWEYQxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWEYQxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWEYQxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:53:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030272AbWEYQxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:53:30 -0400
Date: Thu, 25 May 2006 09:52:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: arjan@linux.intel.com, mingo@elte.hu, tglx@linutronix.de,
       rdunlap@xenotime.net, linux-kernel@vger.kernel.org
Subject: Re: + pi-futex-rt-mutex-docs.patch added to -mm tree
Message-Id: <20060525095242.48c3a310.akpm@osdl.org>
In-Reply-To: <1148573982.16319.9.camel@localhost.localdomain>
References: <200605251502.k4PF21vH027653@shell0.pdx.osdl.net>
	<1148573982.16319.9.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Andrew,
> 
> I see you folded a bunch of doc patches together.  I just want to make
> sure that the updates to my document recommended by Randy Dunlap were
> not missed. I haven't received any verification that they went in.
> 
> Here's links to the patches I'm talking about.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114768226928517&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114768248213413&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114768248205694&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114768444306113&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114776099430012&w=2
> 
> It includes 4 out of 2 patches :)  The last two were add-ons that needed
> to get done.
> 
> Or would it be easier if I fold these into one patch and send it to you?
> 

I'd asked Ingo to redo the patch series, as it had become a straggly mess. 
He had diffed the old patch series against the new and nothing changed in
the documentation area.  So what's there now should be what was in rc4-mm3.

