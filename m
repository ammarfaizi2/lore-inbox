Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWF0JOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWF0JOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWF0JOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:14:31 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64274 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964823AbWF0JOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:14:30 -0400
Date: Tue, 27 Jun 2006 11:14:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm3: no help text for READAHEAD_ALLOW_OVERHEADS
Message-ID: <20060627091429.GK23314@stusta.de>
References: <20060627015211.ce480da6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627015211.ce480da6.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 01:52:11AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm2:
> +readahead-kconfig-option-readahead_allow_overheads.patch
>...
>  readahead updates
>...

The READAHEAD_ALLOW_OVERHEADS option lacks a help text.

Additionally, the "default n" is pointless and should be removed.
 
cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

