Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbULAWqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbULAWqj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 17:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbULAWqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 17:46:38 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47110 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261474AbULAWqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 17:46:25 -0500
Date: Wed, 1 Dec 2004 23:46:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.28 compile problem with gcc-3.4.3
Message-ID: <20041201224623.GA5148@stusta.de>
References: <20041201221051.GR790@thune.sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201221051.GR790@thune.sonic.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 02:10:51PM -0800, Mike Castle wrote:
> 
> Apparently, when building for a 386 kernel with gcc-3.4.3, rwsem-spinlock.c
> fails to build.
> 
> .config and typescript attached.

Thanks for this report.

This is a known bug already fixed in 2.4.29-pre1.

> mrc

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

