Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUKSWfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUKSWfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbUKSWec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:34:32 -0500
Received: from baikonur.stro.at ([213.239.196.228]:17894 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261628AbUKSWbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:31:45 -0500
Date: Fri, 19 Nov 2004 23:31:42 +0100
From: maximilian attems <janitor@sternwelten.at>
To: james4765@verizon.net
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH] floppy: Reorganize drivers/block/floppy.c
Message-ID: <20041119223142.GJ2202@stro.at>
References: <20041105014000.11993.38553.30904@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105014000.11993.38553.30904@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2004, james4765@verizon.net wrote:

> Organization of global variables, macros, and #defines in floppy.c
> 
> Signed-off-by: James Nelson <james4765@gmail.com>
> 
> diff -urN --exclude='*~' linux-2.6.9-original/drivers/block/floppy.c linux-2.6.9/drivers/block/floppy.c
> --- linux-2.6.9-original/drivers/block/floppy.c	2004-10-18 17:53:22.000000000 -0400
> +++ linux-2.6.9/drivers/block/floppy.c	2004-11-04 20:25:28.180478012 -0500

hmm could you split up your patch in logical hunks?
nitpicking: your patch adds whitespace.

a++ maks
