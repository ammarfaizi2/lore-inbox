Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbUKIF7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbUKIF7A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbUKIF4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:56:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:48271 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261402AbUKIFej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:34:39 -0500
Date: Mon, 8 Nov 2004 21:34:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@somerset.sps.mot.com>
Cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][PPC32] Added MPC8555/8541 security block infrastructure
Message-Id: <20041108213428.16dfb1f7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0411082319080.13565@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0411082319080.13565@blarg.somerset.sps.mot.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala <galak@somerset.sps.mot.com> wrote:
>
> This patch adds OCP, interrupt, and memory offset details for the security 
>  block on MPC8555/8541 to support drivers.

Your email client did space-stuffing on the message, so the patch gets 100%
rejects.  I fixed it up by hand and applied the patch locally, thanks.

I think there's a way of telling Pine to stop doing this.
