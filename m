Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267680AbUHFENG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267680AbUHFENG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 00:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267682AbUHFENG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 00:13:06 -0400
Received: from waste.org ([209.173.204.2]:51889 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267680AbUHFENF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 00:13:05 -0400
Date: Thu, 5 Aug 2004 23:12:51 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.8-rc3-mm1 - Fix missing backslash in asm-generic/bug.h
Message-ID: <20040806041251.GV16310@waste.org>
References: <200408060421.i764LtCi005625@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408060421.i764LtCi005625@ccure.user-mode-linux.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 12:21:55AM -0400, Jeff Dike wrote:

> -	panic("BUG!");
> +	panic("BUG!"); \

Eek, thanks Jeff.

-- 
Mathematics is the supreme nostalgia of our time.
