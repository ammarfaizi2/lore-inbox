Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265392AbUEUKOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265392AbUEUKOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 06:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265463AbUEUKON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 06:14:13 -0400
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:49931 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S265392AbUEUKOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 06:14:12 -0400
Date: Fri, 21 May 2004 03:13:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Zhu, Yi" <yi.zhu@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kernel parameter parsing fix
Message-Id: <20040521031331.58483bb3.akpm@osdl.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD54A5@PDSMSX403.ccr.corp.intel.com>
References: <3ACA40606221794F80A5670F0AF15F8403BD54A5@PDSMSX403.ccr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2004 10:13:59.0668 (UTC) FILETIME=[5557FB40:01C43F1C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zhu, Yi" <yi.zhu@intel.com> wrote:
>
> 
> Hi,
> 
> Must all the kernel parameters have trailing '=' at the end of the param
> string?
> If not, I think below patch is useful to avoid potential problems.

Can you explain waht problem this solves?  An example?

> 
> --- linux-2.6.6.orig/init/main.c	2004-05-14 13:38:31.000000000
> +0800

The patch is wordwrapped

