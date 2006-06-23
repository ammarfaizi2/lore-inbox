Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933033AbWFWLGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933033AbWFWLGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 07:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933035AbWFWLGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 07:06:40 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:6569 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S933033AbWFWLGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 07:06:39 -0400
Date: Fri, 23 Jun 2006 07:06:23 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Esben Nielsen <nielsen.esben@googlemail.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <Pine.LNX.4.64.0606230055390.13514@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0606230703430.3835@gandalf.stny.rr.com>
References: <Pine.LNX.4.64.0606230055390.13514@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Jun 2006, Esben Nielsen wrote:

>
> I was bonked for using the other thread for preempt-realtime stuff, so I
> assume this thread is for preempt-realtime stuff only :-)
>

Yep, please use this thread.  We don't want to bother any mainline people
with -rt only issues until it's in mainline ;)

-- Steve

