Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUG2XS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUG2XS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 19:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267467AbUG2XS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 19:18:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10718 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267519AbUG2XSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 19:18:21 -0400
Date: Fri, 30 Jul 2004 01:18:19 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [patch] Re: 2.6.8-rc2-mm1: NTFS compile error with gcc 2.95
Message-ID: <20040729231818.GJ23589@fs.tum.de>
References: <20040728020444.4dca7e23.akpm@osdl.org> <20040729144149.GC2349@fs.tum.de> <20040729155411.GF26643@lug-owl.de> <20040729204250.GD2349@fs.tum.de> <Pine.LNX.4.60.0407292249120.25661@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0407292249120.25661@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 10:51:53PM +0100, Anton Altaparmakov wrote:
>...
> Thanks.  Looks good.  Have you verified that it fixes the gcc-2.95 
> compilation?  If so I will apply it to my tree and Andrew will get it when 
> he does his next pull of the ntfs-2.6-devel repository...

Sure, I verified the compilation with gcc 2.95 before sending this 
patch.

> Thanks,
> 
> 	Anton

Thanks
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

