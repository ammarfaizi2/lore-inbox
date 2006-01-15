Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWAOBub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWAOBub (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 20:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWAOBua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 20:50:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3083 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751572AbWAOBu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 20:50:27 -0500
Date: Sun, 15 Jan 2006 02:50:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       "Andrey J. Melnikoff" <temnota@kmv.ru>
Subject: Re: [2.6 patch] always enable CONFIG_PDC202XX_FORCE
Message-ID: <20060115015027.GY29663@stusta.de>
References: <20060114152119.GN29663@stusta.de> <1137255183.20915.0.camel@localhost.localdomain> <58cb370e0601140947medcb66flf6b7281976683765@mail.gmail.com> <20060114195521.GS29663@stusta.de> <1137287249.26046.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137287249.26046.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 01:07:29AM +0000, Alan Cox wrote:
> On Sad, 2006-01-14 at 20:55 +0100, Adrian Bunk wrote:
> > This patch removes the CONFIG_PDC202XX_FORCE=n case.
> 
> NAK. The Y case is the one you want to keep

Removing the N case is the same as keeping the Y case...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

