Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWF2Tzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWF2Tzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWF2Tzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:55:33 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:2316 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932365AbWF2Tzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:55:31 -0400
Date: Thu, 29 Jun 2006 15:55:02 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Stefano Brivio <stefano.brivio@polimi.it>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
       mb@bu3sch.de, akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] Broadcom wireless patch, PCIE/Mactel support
Message-ID: <20060629195456.GG24463@tuxdriver.com>
References: <44909A3F.4090905@oracle.com> <20060615133220.57d8dd26@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615133220.57d8dd26@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 01:32:20PM +0200, Stefano Brivio wrote:
> On Wed, 14 Jun 2006 16:22:39 -0700
> Randy Dunlap <randy.dunlap@oracle.com> wrote:
> 
> > From: Matthew Garrett <mjg59@srcf.ucam.org>
> > 
> > Broadcom wireless patch, PCIE/Mactel support
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=1373a8487e911b5ee204f4422ddea00929c8a4cc
> > 
> > This patch adds support for PCIE cores to the bcm43xx driver. This is
> > needed for wireless to work on the Intel imacs. I've submitted it to
> > bcm43xx upstream.
> 
> NACK.
> This has been superseded by my patchset:
> http://www.mail-archive.com/bcm43xx-dev@lists.berlios.de/msg01267.html
> 
> I'm still waiting for more testing so I didn't request merging to mainline

Are these patches coming soon?

John
-- 
John W. Linville
linville@tuxdriver.com
