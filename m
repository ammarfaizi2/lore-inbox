Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWCCP0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWCCP0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 10:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWCCP0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 10:26:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48905 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750716AbWCCP0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 10:26:42 -0500
Date: Fri, 3 Mar 2006 16:26:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Andreas Happe <andreashappe@snikt.net>
Cc: linux-kernel@vger.kernel.org, linville@tuxdriver.com, jgarzik@pobox.com,
       netdev@vger.kernel.org
Subject: 2.6.16-rc5-mm2: IPW_QOS: two remarks
Message-ID: <20060303152641.GR9295@stusta.de>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 04:56:51AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc5-mm1:
>...
>  git-netdev-all.patch
>...
>  git trees
>...

Two remarks regarding the new IPW_QOS option:
- it should be named IPW2200_QOS (similar to the other IPW2200_* 
  options)
- please add a help text

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

