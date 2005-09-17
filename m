Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVIQF1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVIQF1W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 01:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVIQF1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 01:27:22 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:14798 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1750934AbVIQF1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 01:27:21 -0400
Date: Sat, 17 Sep 2005 14:27:08 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: Fixed build error
Message-Id: <20050917142708.16e29c4c.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050916213323.0a6499ba.akpm@osdl.org>
References: <20050916022319.12bf53f3.akpm@osdl.org>
	<20050917132521.1d157d50.yuasa@hh.iij4u.or.jp>
	<20050916213323.0a6499ba.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005 21:33:23 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:
> >
> >  This patch has fixed the following build error on MIPS.
> >
> 
> Great, thaks for that.
> 
> Do you actually run-time test -mm kernels on MIPS or do you only compile-test?
> 

I always actually run-time test it on MIPS.

Yoichi
