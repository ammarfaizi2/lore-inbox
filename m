Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSGVN1C>; Mon, 22 Jul 2002 09:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSGVN1C>; Mon, 22 Jul 2002 09:27:02 -0400
Received: from verein.lst.de ([212.34.181.86]:2828 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S317078AbSGVN1A>;
	Mon, 22 Jul 2002 09:27:00 -0400
Date: Mon, 22 Jul 2002 15:30:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
Message-ID: <20020722153000.A18763@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
References: <20020722152645.A18695@lst.de> <Pine.LNX.4.44.0207221526380.8286-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207221526380.8286-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Jul 22, 2002 at 03:26:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 03:26:57PM +0200, Ingo Molnar wrote:
> no, the on is not implicit at all. If you restore into a disabled state
> then it will go from on to off.

well, for the normal use of it.  Okay, I give up, even if the nameing
looks strange in the beginning is is consistant :)

