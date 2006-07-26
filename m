Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWGZMWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWGZMWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWGZMWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:22:36 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:19596 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751059AbWGZMWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:22:36 -0400
Subject: Re: [PATCH] reference rt-mutex-design in rtmutex.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20060726081631.GC11604@elte.hu>
References: <Pine.LNX.4.58.0607210942410.1190@gandalf.stny.rr.com>
	 <20060726081631.GC11604@elte.hu>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 08:22:25 -0400
Message-Id: <1153916545.6270.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 10:16 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > + *  Before making any design changes to this file, please refer to
> > + *  Documentation/rt-mutex-design.txt and update accordingly.
> 
> please change this to:
> 
>  + * See Documentation/rt-mutex-design.txt for details.

OK will do.  But I still like the idea that we imply being hit with a
wet noodle if you don't update the document ;)

-- Steve


