Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVLQEoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVLQEoK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 23:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVLQEoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 23:44:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33032 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750808AbVLQEoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 23:44:09 -0500
Date: Sat, 17 Dec 2005 05:44:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: Matt Mackall <mpm@selenic.com>
Subject: remove CONFIG_UID16
Message-ID: <20051217044410.GO23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems noone noticed that CONFIG_UID16 was accidentially always 
disabled in the latest -mm kernels.

Is there any reason against removing it completely?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


