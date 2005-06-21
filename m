Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVFUUS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVFUUS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVFUURT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:17:19 -0400
Received: from kanga.kvack.org ([66.96.29.28]:4055 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261453AbVFUUQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:16:00 -0400
Date: Tue, 21 Jun 2005 16:17:42 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: William Weston <weston@sysex.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-ns83820@kvack.org,
       nhorman@redhat.com, Jeff Garzik <jgarzik@redhat.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050621201742.GA16400@kvack.org>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org> <20050621131009.GA22691@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621131009.GA22691@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 03:10:09PM +0200, Ingo Molnar wrote:
> find the patch below - it's also included in the -50-05 -RT tree i just 
> uploaded. Can you confirm that you dont get the warnings in the -50-05 
> (and later) -RT kernels?

Looks good.  Acked-by: Benjamin LaHaise <bcrl@kvack.org>

		-ben
