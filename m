Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSGXLzy>; Wed, 24 Jul 2002 07:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317017AbSGXLzy>; Wed, 24 Jul 2002 07:55:54 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:8720 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317012AbSGXLzv>; Wed, 24 Jul 2002 07:55:51 -0400
Date: Wed, 24 Jul 2002 12:59:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] irqlock patch 2.5.27-H4
Message-ID: <20020724125903.A5961@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <Pine.LNX.4.44.0207241344160.14551-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207241344160.14551-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Jul 24, 2002 at 01:47:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - move the irqs-off check into preempt_schedule() and remove
>    CONFIG_DEBUG_IRQ_SCHEDULE.

the config.in entry is still present..

