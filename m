Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUIOTwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUIOTwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUIOTwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:52:09 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:32992 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S267344AbUIOTwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:52:03 -0400
Date: Wed, 15 Sep 2004 21:51:36 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040915195136.GB4197@dualathlon.random>
References: <20040913061641.GA11276@elte.hu> <41489B7A.6010407@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41489B7A.6010407@tmr.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 03:43:54PM -0400, Bill Davidsen wrote:
> Okay, I'll be the one to ask... what overload of the IPL acronym are you 

in this context I parsed it as interrupt priority level.
