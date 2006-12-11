Return-Path: <linux-kernel-owner+w=401wt.eu-S937183AbWLKQmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937183AbWLKQmS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937187AbWLKQmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:42:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3450 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S937183AbWLKQmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:42:16 -0500
Date: Mon, 11 Dec 2006 17:42:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Artem Bityutskiy <dedekind@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.19-mm1: missing MTD_UBI* help texts
Message-ID: <20061211164225.GO10351@stusta.de>
References: <20061211005807.f220b81c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211005807.f220b81c.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 12:58:07AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc6-mm2:
>...
>  git-ubi.patch
>...
>  git trees.
>...

The MTD_UBI and the MTD_UBI_DEBUG_PARANOID_* options lack help texts.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

