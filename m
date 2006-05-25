Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWEYRAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWEYRAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 13:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWEYRAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 13:00:42 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:50852 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030281AbWEYRAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 13:00:41 -0400
Date: Thu, 25 May 2006 13:00:31 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andrew Morton <akpm@osdl.org>
cc: arjan@linux.intel.com, mingo@elte.hu, tglx@linutronix.de,
       rdunlap@xenotime.net, linux-kernel@vger.kernel.org
Subject: Re: + pi-futex-rt-mutex-docs.patch added to -mm tree
In-Reply-To: <20060525095242.48c3a310.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0605251258110.18540@gandalf.stny.rr.com>
References: <200605251502.k4PF21vH027653@shell0.pdx.osdl.net>
 <1148573982.16319.9.camel@localhost.localdomain> <20060525095242.48c3a310.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 May 2006, Andrew Morton wrote:

> >
> > Or would it be easier if I fold these into one patch and send it to you?
> >
>
> I'd asked Ingo to redo the patch series, as it had become a straggly mess.
> He had diffed the old patch series against the new and nothing changed in
> the documentation area.  So what's there now should be what was in rc4-mm3.
>

OK, so I guess the update patches that had the changes that Randy
suggested, got lost in the LKML noise.  I'll fold them up and send a
single patch that should go against what is in rc4-mm3.

Thanks,

-- Steve
