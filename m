Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVBWVbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVBWVbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVBWVbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:31:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53513 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261609AbVBWVat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:30:49 -0500
Date: Wed, 23 Feb 2005 22:30:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1
Message-ID: <20050223213044.GD3432@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223014233.6710fd73.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 01:42:33AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-rc3-mm1:
>...
>  bk-kbuild.patch
>...

This adds -Wno-pointer-sign to the main Makefile a second time.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

