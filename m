Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965600AbVKGX32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965600AbVKGX32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965601AbVKGX32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:29:28 -0500
Received: from holomorphy.com ([66.93.40.71]:23266 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S965600AbVKGX32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:29:28 -0500
Date: Mon, 7 Nov 2005 15:25:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/hugetlbfs/inode.c: make a function static
Message-ID: <20051107232516.GF29402@holomorphy.com>
References: <20051107211903.GC3847@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107211903.GC3847@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 10:19:03PM +0100, Adrian Bunk wrote:
> This patch makes a needlessly global function static.
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: William Irwin <wli@holomorphy.com>

If it clashes with Adam Litke's patches, please rediff and send after.


-- wli
