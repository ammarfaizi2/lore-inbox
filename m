Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268590AbUJEBR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268590AbUJEBR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 21:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268602AbUJEBR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 21:17:29 -0400
Received: from mail.renesas.com ([202.234.163.13]:37346 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S268590AbUJEBR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 21:17:28 -0400
Date: Tue, 05 Oct 2004 10:16:51 +0900 (JST)
Message-Id: <20041005.101651.336469738.takata.hirokazu@renesas.com>
To: hch@lst.de
Cc: takata@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: Re: remaining m32r issues
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20041002160036.GA18784@lst.de>
References: <20041002160036.GA18784@lst.de>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat, 2 Oct 2004 18:00:36 +0200
> We're getting close to 2.6.9, aka the first release with official m32r
> support.  So could you please remove the obsolete syscalls from the
> default config so we don't have to support them forever?
> 
> Also there's still arch/m32r/drivers, and it adds new MOD_INC_USE_COUNT
> users - but that one has been completely removed in -mm already

Sorry for my late reply. I was offline in these three days.
I'am trying to deal with them now.

-- Takata
