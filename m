Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423415AbWJZFZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423415AbWJZFZz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 01:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423414AbWJZFZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 01:25:55 -0400
Received: from www.osadl.org ([213.239.205.134]:61346 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1423415AbWJZFZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 01:25:54 -0400
Subject: Re: [PATCH] silence 'make xmldocs' warning by adding missing
	description of 'raw' in nand_base.c:1485
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Steven J.Hill" <sjhill@realitydiluted.com>
In-Reply-To: <200610260143.24694.jesper.juhl@gmail.com>
References: <200610260143.24694.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 07:27:02 +0200
Message-Id: <1161840423.31783.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-26 at 01:43 +0200, Jesper Juhl wrote:
> 'make xmldocs' currently gives me this warning :
> 
>     Warning(/home/juhl/download/kernel/linux-2.6//drivers/mtd/nand/nand_base.c:1485): No description found for parameter 'raw'
> 
> This patch silences the warning by adding a description for 'raw'
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

ACK
	tglx


