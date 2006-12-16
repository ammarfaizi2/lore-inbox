Return-Path: <linux-kernel-owner+w=401wt.eu-S1030427AbWLPAEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWLPAEm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 19:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbWLPAEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 19:04:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1837 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030427AbWLPAEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 19:04:41 -0500
Date: Sat, 16 Dec 2006 01:04:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc1-mm1: unused sysrq_timer_list_show()
Message-ID: <20061216000440.GY3388@stusta.de>
References: <20061214225913.3338f677.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 10:59:13PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-mm1:
>...
> +debugging-feature-proc-timer_list.patch
> 
>  Refreshed, refactored dynticks/hrtimer queue.
>...

I'd assume sysrq_timer_list_show() wasn't intended to be unused?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

