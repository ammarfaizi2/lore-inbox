Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWC0GPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWC0GPE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 01:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWC0GPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 01:15:03 -0500
Received: from mail.parknet.jp ([210.171.160.80]:20228 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1750730AbWC0GPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 01:15:01 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/fat/: proper prototypes for two functions
References: <20060326210827.GT4053@stusta.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 27 Mar 2006 15:14:52 +0900
In-Reply-To: <20060326210827.GT4053@stusta.de> (Adrian Bunk's message of "Sun, 26 Mar 2006 23:08:27 +0200")
Message-ID: <87bqvs9zxf.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> This patch adds proper prototypes for fat_cache_init() and 
> fat_cache_destroy() in msdos_fs.h.

Looks good. Please apply.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
