Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWEJHhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWEJHhn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWEJHhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:37:43 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:57086 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932289AbWEJHhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:37:42 -0400
Date: Wed, 10 May 2006 03:37:20 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: akpm@osdl.org
cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Document futex PI design
In-Reply-To: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 May 2006, Steven Rostedt wrote:

> Andrew,
>
> Here's a design document of the code that implements Ingo Molnar's and
> Thomas Gleixner's futex PI code (kernel/rtmutex.c).  Since that code is
> somewhat complex, I spent the time to write up this document that should
> help others understand what was done and why.
>

Andrew,

I've noticed that since this document is rather large, it should have a
copyright notice attached.  I would like to put it under the GFDL.  Should
I send a new patch with the stated license, or should I just send a patch
to the previous patch I sent.

Thanks,

-- Steve

