Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266900AbUHOVYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266900AbUHOVYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 17:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266901AbUHOVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 17:24:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:26265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266900AbUHOVYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 17:24:53 -0400
Date: Sun, 15 Aug 2004 14:23:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH][PPC32] Make PPC40x large tlb mapping optional
Message-Id: <20040815142317.71884f78.akpm@osdl.org>
In-Reply-To: <20040811105217.B8378@home.com>
References: <20040811105217.B8378@home.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter <mporter@kernel.crashing.org> wrote:
>
> This makes the PPC40x lowmem large tlb mapping selectable via
>  a cmdline option.

Please send a separate update to Documentation/kernel-parameters.txt.
