Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbVCXCgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbVCXCgG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 21:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVCXCgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 21:36:06 -0500
Received: from fire.osdl.org ([65.172.181.4]:59048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262980AbVCXCgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 21:36:05 -0500
Date: Wed, 23 Mar 2005 18:35:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, sugai@isl.melco.co.jp,
       ysato@users.sourceforge.jp, inaoka.kazuhiro@renesas.com,
       fujiwara@linux-m32r.org, takata@linux-m32r.org
Subject: Re: [PATCH 2.6.12-rc1] m32r: Update MMU-less support (0/3)
Message-Id: <20050323183535.658d4faf.akpm@osdl.org>
In-Reply-To: <20050324.104815.304093279.takata.hirokazu@renesas.com>
References: <20050324.104815.304093279.takata.hirokazu@renesas.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takata <takata@linux-m32r.org> wrote:
>
> Here is a patchset to update m32r's MMU-less support.

I'd prefer it if you could avoid sending multiple patches with the same
title in future, please.  It mucks up my patch naming and tracking system,
and surely all three patches weren't doing the same thing?

More at http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, thanks.
