Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTB0IWZ>; Thu, 27 Feb 2003 03:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTB0IWZ>; Thu, 27 Feb 2003 03:22:25 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6131 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261874AbTB0IWY>; Thu, 27 Feb 2003 03:22:24 -0500
Date: Thu, 27 Feb 2003 09:32:39 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, ajoshi@kernel.crashing.org,
       bcollins@debian.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre5
Message-ID: <20030227083238.GS7685@fs.tum.de>
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 03:14:44AM -0300, Marcelo Tosatti wrote:
> 
> So here goes -pre5.
> 
> 
> Summary of changes from v2.4.21-pre4 to v2.4.21-pre5
> ============================================
> 
> <ajoshi@kernel.crashing.org>:
>   o rivafb 0.9.4 update
>...

WTF is this???

Besides the rivafb update it reverts parts of the IEEE 1394 patches that 
were included in -pre4.


Please revert these bogus changes.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

