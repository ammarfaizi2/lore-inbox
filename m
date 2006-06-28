Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbWF1WpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbWF1WpE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWF1WpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:45:04 -0400
Received: from mail.jdl.com ([66.118.10.122]:58827 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751646AbWF1WpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:45:03 -0400
To: Kumar Gala <galak@kernel.crashing.org>
cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Please pull from 'for_paulus' branch of powerpc 
In-Reply-To: Your message of "Wed, 28 Jun 2006 01:01:12 CDT."
             <Pine.LNX.4.44.0606280057580.2211-100000@gate.crashing.org> 
References: <Pine.LNX.4.44.0606280057580.2211-100000@gate.crashing.org> 
Date: Wed, 28 Jun 2006 17:44:57 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1FvimH-00054M-8s@jdl.com>
X-Spam-Score: -5.9 (-----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, like, the other day Kumar Gala mumbled:
> Please pull from 'for_paulus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git
> 
> to receive the following updates:
> 
>  arch/powerpc/kernel/cputable.c             |   12 --
>  arch/powerpc/platforms/86xx/mpc86xx.h      |    8 +
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |  128 +++++++++++++++++++++++++-
> -
>  arch/powerpc/platforms/86xx/mpc86xx_smp.c  |    9 -
>  arch/powerpc/platforms/86xx/pci.c          |  136 +-------------------------
> ---
>  include/asm-powerpc/mpc86xx.h              |    4 
>  6 files changed, 138 insertions(+), 159 deletions(-)
> 
> Kumar Gala:
>       powerpc: minor cleanups for mpc86xx
> 

Kumar,

Looks good to me.  I'll pull them to the 86xx tree.

Thanks!
jdl
