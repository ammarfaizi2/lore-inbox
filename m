Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271739AbTGRGdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 02:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271738AbTGRGdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 02:33:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50409 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271736AbTGRGdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 02:33:45 -0400
Date: Thu, 17 Jul 2003 23:38:49 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ben Collins <bcollins@debian.org>
Cc: marcelo@conectiva.com.br, alan@redhat.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Fix ALi15x3 DMA on sparc64 (maybe others)
Message-Id: <20030717233849.102250cb.davem@redhat.com>
In-Reply-To: <20030717181410.GI1171@phunnypharm.org>
References: <20030717181410.GI1171@phunnypharm.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003 14:14:10 -0400
Ben Collins <bcollins@debian.org> wrote:

> Attached is a patch that is known to fix atleast the DMA corruption
> occuring on sparc64 in 2.4.x kernels for ALi15x3 IDE chipsets. I think
> Alan hinted that someone also reported it fixed a similar problem on
> alpha.

Marcelo, please apply this.  Not only does it indeed fix
problems on Sparc64 and Alpha, it also is ACK'd by Alan
and already present in 2.5.x

Thanks.
