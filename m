Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755085AbWKQMmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085AbWKQMmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 07:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933575AbWKQMmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 07:42:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43278 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755084AbWKQMmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 07:42:39 -0500
Date: Fri, 17 Nov 2006 13:42:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: -mm: cx88-blackbird.c: unused code re-added
Message-ID: <20061117124238.GV31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
>  git-dvb.patch
>...
>  git trees
>...

Why does this patch re-add the still unused cx88_ioctl_hook and 
cx88_ioctl_translator in drivers/media/video/cx88/cx88-blackbird.c 
I removed a few months ago?
 
cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

