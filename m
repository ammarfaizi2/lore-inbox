Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751742AbWEPKZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbWEPKZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 06:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWEPKZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 06:25:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17170 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751742AbWEPKZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 06:25:57 -0400
Date: Tue, 16 May 2006 12:25:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: 2.6.17-rc4-mm1: no help text for MTD_NAND_CS553
Message-ID: <20060516102554.GL6931@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 12:56:37AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc3-mm1:
>...
>  git-mtd.patch
>...
>  git trees
>...

This patch adds an MTD_NAND_CS553 option without a help text.

Please add at least a small help text.

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

