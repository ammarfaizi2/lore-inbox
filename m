Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVGEJx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVGEJx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 05:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVGEJx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 05:53:57 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:43927 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261776AbVGEJxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 05:53:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-5.2.1 for 2.6.11 and 2.6.12
Date: Tue, 5 Jul 2005 19:53:48 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <42B65525.1060308@bigpond.net.au> <42B65FAC.4090400@bigpond.net.au> <42CA3AEA.3020204@bigpond.net.au>
In-Reply-To: <42CA3AEA.3020204@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507051953.49132.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005 17:46, Peter Williams wrote:
> Peter Williams wrote:
> > Con Kolivas wrote:
> >> On Mon, 20 Jun 2005 15:33, Peter Williams wrote:
> >>> PlugSched-5.2.1 is available for 2.6.11 and 2.6.12 kernels.  This
> >>> version applies Con Kolivas's latest modifications to his "nice" aware
> >>> SMP load balancing patches.
> >>
> >> Thanks Peter.
> >> Any word from your own testing/testers on how well smp nice balancing
> >> is working for them now?
> >
> > No, they got side tracked onto something else but should start working
> > on it again soon.  I'll give them a prod :-)
>
> Con,
> 	We've done some more testing with this with results that are still
> disappointing. 

Is this with the migration thread accounted patch as well?

Con
