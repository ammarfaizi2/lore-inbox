Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVH3OwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVH3OwB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVH3OwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:52:00 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60938 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932165AbVH3Ov7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:51:59 -0400
Date: Tue, 30 Aug 2005 16:51:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
       James.Bottomley@steeleye.com
Subject: Re: [PATCH] fix compiler warning in aic7770
Message-ID: <20050830145157.GB3708@stusta.de>
References: <200508300115.47618.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508300115.47618.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 01:15:36AM +0200, Jesper Juhl wrote:

> Fix compiler warning in drivers/scsi/aic7xxx/aic7770.c : 
>    drivers/scsi/aic7xxx/aic7770.c:129: warning: unused variable `l'
>...

This patch is already in 2.6.13-rc6-mm2 (through the scsi-misc-2.6.git 
tree).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

