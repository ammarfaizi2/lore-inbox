Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVJGJls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVJGJls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 05:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVJGJls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 05:41:48 -0400
Received: from farad.aurel32.net ([82.232.2.251]:15311 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S932267AbVJGJlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 05:41:47 -0400
Date: Fri, 7 Oct 2005 11:41:35 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Lionel.Bouton@inet6.fr, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc3] sis5513.c: enable ATA133 for the SiS965 southbridge
Message-ID: <20051007094135.GA16386@farad.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Lionel.Bouton@inet6.fr, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
References: <20051005205906.GA4320@farad.aurel32.net> <58cb370e0510060240x2f2e31c3kd0609a06172d86a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <58cb370e0510060240x2f2e31c3kd0609a06172d86a4@mail.gmail.com>
X-Mailer: Mutt 1.5.9i (2005-03-13)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 11:40:15AM +0200, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On 10/5/05, Aurelien Jarno <aurelien@aurel32.net> wrote:
> > Hi,
> >
> > Here is a patch that enables the ATA133 mode for the SiS965 southbridge
> > in the SiS5513 driver.
> 
> The patch for SIS965(L) support is already in -mm tree:
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/broken-out/sis5513-support-sis-965l.patch
> 

Oops, I forget to look at the -mm tree for this driver. You're right, it
works, and it seems the patch is cleaner than mine. So please ignore my
patch.

Thanks,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
