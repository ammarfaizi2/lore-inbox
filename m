Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbULBQz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbULBQz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbULBQz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:55:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:46791 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261668AbULBQzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:55:52 -0500
Date: Thu, 2 Dec 2004 08:55:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: tglx@linutronix.de, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-Id: <20041202085518.58e0e8eb.akpm@osdl.org>
In-Reply-To: <20041202164725.GB32635@dualathlon.random>
References: <20041201104820.1.patchmail@tglx>
	<20041201211638.GB4530@dualathlon.random>
	<1101938767.13353.62.camel@tglx.tec.linutronix.de>
	<20041202033619.GA32635@dualathlon.random>
	<1101985759.13353.102.camel@tglx.tec.linutronix.de>
	<1101995280.13353.124.camel@tglx.tec.linutronix.de>
	<20041202164725.GB32635@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> I believe the thing you're hiding with the callback, is some screwup in
>  the VM. It shouldn't fire oom 300 times in a row.

Well no ;)

Thomas, could you please put together a description of how to reproduce
this behaviour?

