Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945981AbWBOPY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945981AbWBOPY3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945982AbWBOPY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:24:29 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:51868 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1945981AbWBOPY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:24:28 -0500
Date: Wed, 15 Feb 2006 16:22:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
Message-ID: <20060215152244.GA32729@elte.hu>
References: <20060215151711.GA31569@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215151711.GA31569@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> This patchset provides a new (written from scratch) implementation of 
> robust futexes, called "lightweight robust futexes". We believe this 
> new implementation is faster and simpler than the vma-based robust 
> futex solutions presented before, and we'd like this patchset to be 
> adopted in the upstream kernel. This is version 1 of the patchset.

the patchset can also be downloaded from:

  http://redhat.com/~mingo/lightweight-robust-futexes/

	Ingo
