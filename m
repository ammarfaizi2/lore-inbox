Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267478AbTBUPCv>; Fri, 21 Feb 2003 10:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267480AbTBUPCu>; Fri, 21 Feb 2003 10:02:50 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44483 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267478AbTBUPCj>; Fri, 21 Feb 2003 10:02:39 -0500
Date: Fri, 21 Feb 2003 16:12:39 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.62-ac1
Message-ID: <20030221151239.GP531@fs.tum.de>
References: <200302202233.h1KMX8408821@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302202233.h1KMX8408821@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 05:33:08PM -0500, Alan Cox wrote:

>...
> Linux 2.5.62-ac1
>...
> o	FBdev updates					(James Simmons)
>...

FYI:

The Logo changes seem to be incomplete, at least pnmtologo is missing:

<--  snip  -->

...
./scripts/pnmtologo -t mono -n logo_linux_mono -o drivers/video/logo/logo_linux_mono.c drivers/video/logo/logo_linux_mono.pbm
make[3]: ./scripts/pnmtologo: Command not found
make[3]: *** [drivers/video/logo/logo_linux_mono.c] Error 127

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

