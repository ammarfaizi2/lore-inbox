Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVAAUYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVAAUYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 15:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVAAUYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 15:24:09 -0500
Received: from main.gmane.org ([80.91.229.2]:45537 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261171AbVAAUYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 15:24:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] =?utf-8?b?L3Byb2Mvc3lzL2tlcm5lbC9ib290bG9hZGVyX3R5cGU=?=
Date: Sat, 1 Jan 2005 20:22:30 +0000 (UTC)
Message-ID: <loom.20050101T211932-0@post.gmane.org>
References: <41D34E3A.3090708@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.39.219.80 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041228 Firefox/1.0 Fedora/1.0-8)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin <hpa <at> zytor.com> writes:

> 
> This patch exports to userspace the boot loader ID which has been 
> exported by (b)zImage boot loaders since boot protocol version 2.

Isn't /sys/kernel/bootloader_type a better place than /proc for new values?

Thanks,
Kay

