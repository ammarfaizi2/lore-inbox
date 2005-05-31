Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVEaAOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVEaAOn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVEaAKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:10:46 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:12737
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261839AbVEaAGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 20:06:49 -0400
Subject: Re: RT patch acceptance
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: karim@opersys.com
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       Nick Piggin <nickpiggin@yahoo.com.au>, kus Kusche Klaus <kus@keba.com>,
       James Bruce <bruce@andrew.cmu.edu>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <429B9E85.2000709@opersys.com>
References: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk>
	 <429B61F7.70608@opersys.com> <20050530223434.GC9972@nietzsche.lynx.com>
	 <429B9880.1070604@opersys.com> <20050530224949.GE9972@nietzsche.lynx.com>
	 <429B9E85.2000709@opersys.com>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 31 May 2005 02:07:25 +0200
Message-Id: <1117498045.14566.24.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 19:15 -0400, Karim Yaghmour wrote:
> Sure, but like Andi said, general increased responsiveness is not exclusive
> to PREEMPT_RT, and any effort to reduce latency is welcome.

Nobody denies that, but thats no argument against a RT extension.

> But wasn't the same said about the existing preemption code? Yet, most
> distros ship with it disabled and some developers still feel that there
> are no added benefits. 

One of the most disgusting arguments in this thread is "distros do XYZ".

There is a lot of Linux beyond distros. 

tglx


