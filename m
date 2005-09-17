Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVIQEd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVIQEd7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 00:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbVIQEd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 00:33:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52440 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750901AbVIQEd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 00:33:58 -0400
Date: Fri, 16 Sep 2005 21:33:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: Fixed build error
Message-Id: <20050916213323.0a6499ba.akpm@osdl.org>
In-Reply-To: <20050917132521.1d157d50.yuasa@hh.iij4u.or.jp>
References: <20050916022319.12bf53f3.akpm@osdl.org>
	<20050917132521.1d157d50.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:
>
>  This patch has fixed the following build error on MIPS.
>

Great, thaks for that.

Do you actually run-time test -mm kernels on MIPS or do you only compile-test?
