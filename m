Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWCTGXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWCTGXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWCTGXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:23:16 -0500
Received: from mo00.po.2iij.net ([210.130.202.204]:65246 "EHLO
	mo00.po.2iij.net") by vger.kernel.org with ESMTP id S1751651AbWCTGXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:23:15 -0500
Date: Mon, 20 Mar 2006 15:23:02 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: yoichi_yuasa@tripeaks.co.jp, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH 3/12] [MIPS] Remove tb0287_defconfig
Message-Id: <20060320152302.22588fd8.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060320043926.GC20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
	<20060320043926.GC20416@deprecation.cyrius.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006 04:39:26 +0000
Martin Michlmayr <tbm@cyrius.com> wrote:

> Remove the tb0287 defconfig file since this platform is no longer
> supported.  This brings mainline in sync with the linux-mips tree.

The TB0287 is supported.
I'm testing -rc and -mm release on TB0287.

Yoichi
