Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWIPW5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWIPW5u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 18:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWIPW5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 18:57:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964809AbWIPW5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 18:57:49 -0400
Date: Sat, 16 Sep 2006 15:57:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: karim@opersys.com
Cc: Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>, fche@redhat.com
Subject: Re: [patch] kprobes: optimize branch placement
Message-Id: <20060916155704.ef425542.akpm@osdl.org>
In-Reply-To: <450C7039.20208@opersys.com>
References: <Pine.LNX.4.64.0609152111030.6761@scrub.home>
	<20060915200559.GB30459@elte.hu>
	<20060915202233.GA23318@Krystal>
	<450BCAF1.2030205@sgi.com>
	<20060916172419.GA15427@Krystal>
	<20060916173552.GA7362@elte.hu>
	<20060916175606.GA2837@Krystal>
	<20060916191043.GA22558@elte.hu>
	<20060916193745.GA29022@elte.hu>
	<20060916202939.GA4520@elte.hu>
	<20060916204342.GA5208@elte.hu>
	<450C7039.20208@opersys.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2006 17:44:25 -0400
Karim Yaghmour <karim@opersys.com> wrote:

> So now you're resorting to your uber-talents as a kernel guru to bury
> the other side?

It's hardly rocket science - it appears that nobody has ever bothered.



