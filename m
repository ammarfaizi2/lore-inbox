Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVFBU4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVFBU4Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFBU4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:56:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47112 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261340AbVFBUya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:54:30 -0400
Date: Thu, 2 Jun 2005 22:54:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.12-rc5-mm2
Message-ID: <20050602205422.GK4992@stusta.de>
References: <20050601022824.33c8206e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601022824.33c8206e.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

in case 2.6.12 should fully support gcc 4.0:

The only patch from -mm that seems to be required for fixing a 
compilation on i386 with gcc 4.0 is
  drivers-net-hamradio-baycom_eppc-cleanups.patch

Whether this is feasible or not is your choice.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

