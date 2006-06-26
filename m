Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWFZF1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWFZF1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 01:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWFZF1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 01:27:43 -0400
Received: from mo30.po.2iij.net ([210.128.50.53]:4409 "EHLO mo30.po.2iij.net")
	by vger.kernel.org with ESMTP id S964776AbWFZF1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 01:27:42 -0400
Message-Id: <200606260527.k5Q5RSBj044481@mbox31.po.2iij.net>
Date: Mon, 26 Jun 2006 14:27:28 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][MIPS] wire up tee system call
In-Reply-To: <20060623011148.1a57b6a7.akpm@osdl.org>
References: <20060623170711.3a6d1ef8.yoichi_yuasa@tripeaks.co.jp>
	<20060623011148.1a57b6a7.akpm@osdl.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, 23 Jun 2006 01:11:48 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Fri, 23 Jun 2006 17:07:11 +0900
> Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> 
> > This patch wires up tee system call for MIPS.
> 
> Thanks.  Was the syscall tested on MIPS?

Yes, I've tested by Jens Axboe's test program(included in his patch).

Yoichi 
