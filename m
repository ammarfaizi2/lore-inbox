Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVHDA5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVHDA5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVHDA5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:57:32 -0400
Received: from waste.org ([216.27.176.166]:58274 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261716AbVHDAzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:55:10 -0400
Date: Wed, 3 Aug 2005 17:55:04 -0700
From: Matt Mackall <mpm@selenic.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 11/15] KGDB: KGDBoE I/O driver
Message-ID: <20050804005504.GE7425@waste.org>
References: <resend.10.2972005.trini@kernel.crashing.org> <1.2972005.trini@kernel.crashing.org> <resend.11.2972005.trini@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <resend.11.2972005.trini@kernel.crashing.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 02:20:55PM -0700, Tom Rini wrote:
> 
> This is the simple KGDB over Ethernet I/O driver that uses netpoll for all of
> the heavy lifting.  At one point this was very similar to the version Matt
> Mackall wrote and is currently in Andrew's tree.  Since then it has been
> reworked to fit into our model.

Looks good to me.

-- 
Mathematics is the supreme nostalgia of our time.
