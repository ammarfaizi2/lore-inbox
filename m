Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWA3RK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWA3RK2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWA3RK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:10:28 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:15051 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964801AbWA3RK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:10:27 -0500
Subject: Re: 2.6.15-rt16
From: Steven Rostedt <rostedt@goodmis.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, chris <cperkins@OCF.Berkeley.EDU>
In-Reply-To: <1138640592.12625.0.camel@localhost.localdomain>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 12:09:47 -0500
Message-Id: <1138640987.8221.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 18:03 +0100, Thomas Gleixner wrote:
> On Mon, 2006-01-30 at 08:49 -0800, chris wrote:
> > hi,
> > i'm trying to use ingo's 2.6.15-rt16 patch on an x86_64 machine but it 
> > keeps crashing in kmem_cache_init during bootup. i've tried older 
> > 2.6.15-rtX patches and they all crash during startup but vanilla 2.6.15 
> > works fine for me. anyone else seen this happen with realtime-preempt 
> > patches? here's the message:
> 
> Can you please send me your .config file ?
> 

CC me too, when you send this.

Thanks,

-- Steve


