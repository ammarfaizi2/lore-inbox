Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUCXUVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUCXUVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:21:06 -0500
Received: from main.gmane.org ([80.91.224.249]:11155 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261426AbUCXUVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:21:02 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <news_0403@flatline.ath.cx>
Subject: Re: 2.6.5-rc2-mm2
Date: Wed, 24 Mar 2004 19:54:58 +0100
Message-ID: <slrnc63mc2.18m.news_0403@flatline.ath.cx>
References: <20040323232511.1346842a.akpm@osdl.org>
Reply-To: Andreas Happe <news_0403@flatline.ath.cx>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chello062178006202.3.11.tuwien.teleweb.at
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-03-24, Andrew Morton <akpm@osdl.org> wrote:
> -initramfs-search-for-init.patch
> -initramfs-search-for-init-zombie-fix.patch
> +initramfs-search-for-init-orig.patch
>
>  Go back to the original, simple version of this patch.

2.6.5-rc2-mm2 still hangs after:
| VFS: mounted root (ext3 filesystem) readonly
| Freeing unused kernel memory: 140kB

SysRq still works, what information would you need to solve that
problem?

--Andreas

