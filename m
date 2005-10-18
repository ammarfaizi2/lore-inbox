Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVJRNtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVJRNtB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 09:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVJRNtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 09:49:00 -0400
Received: from mail6.hitachi.co.jp ([133.145.228.41]:16357 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1750722AbVJRNs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 09:48:59 -0400
Date: Tue, 18 Oct 2005 22:48:23 +0900 (JST)
Message-Id: <20051018.224823.03979969.noboru.obata.ar@hitachi.com>
To: indou.takao@soft.fujitsu.com
Cc: akpm@osdl.org, hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
From: OBATA Noboru <noboru.obata.ar@hitachi.com>
In-Reply-To: <C0C5D30C9A813Cindou.takao@soft.fujitsu.com>
References: <C0C5D30C9A813Cindou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Indoh-san,

On Mon, 17 Oct 2005, Takao Indoh wrote:
> 
> The 2nd issue (memory size problem) may be solved by exporting
> diskdump's functions to kdump.

Could you briefly explain the implementation of partial dump in
diskdump for those who are not familiar with it?

- Levels of partial dump (supported page categories)
- How to indentify the category (kernel data structure used)

Regards,

-- 
OBATA Noboru (noboru.obata.ar@hitachi.com)

