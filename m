Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbUKGBdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbUKGBdH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 20:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbUKGBdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 20:33:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2834 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261510AbUKGBcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 20:32:55 -0500
Date: Sun, 7 Nov 2004 02:32:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: 2.6.10-rc1-mm3: "bttv card=" breakage
Message-ID: <20041107013219.GB1295@stusta.de>
References: <20041105001328.3ba97e08.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105001328.3ba97e08.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 12:13:28AM -0800, Andrew Morton wrote:
>...
> All 465 patches:
>...
> remove-module_parm-from-allyesconfig-almost.patch
>   Remove MODULE_PARM from allyesconfig (almost)
>...

Does this patch cause the breakage described in Bugzilla #3707?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

