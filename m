Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbTD1ShZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 14:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbTD1ShZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 14:37:25 -0400
Received: from havoc.daloft.com ([64.213.145.173]:6572 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261233AbTD1ShY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 14:37:24 -0400
Date: Mon, 28 Apr 2003 14:49:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org
Subject: Re: [Patch] DMA mapping API for Alpha
Message-ID: <20030428184941.GC18304@gtf.org>
References: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrp65oycvrw.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 08:38:27PM +0200, Marc Zyngier wrote:
> As part of my effort to get the Jensen up and running on the latest
> 2.5 kernels, I have introduced some support for the DMA API, rather
> than relying on the generic PCI based one (which introduces problems
> with the EISA bus).

You want Linux to continue to work on the Jensen?  Scary.

<grin>

	Jeff



