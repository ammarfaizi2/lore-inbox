Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVBJXS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVBJXS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 18:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVBJXS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 18:18:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46596 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261893AbVBJXRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 18:17:52 -0500
Date: Fri, 11 Feb 2005 00:17:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050210231748.GL2958@stusta.de>
References: <20050210023508.3583cf87.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210023508.3583cf87.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 02:35:08AM -0800, Andrew Morton wrote:
>...
> - Various other stuff.  If anyone has a patch in here which they think
>   should be in 2.6.11, please let me know.  I'm intending to merge the
>   following into 2.6.11:
> 
> 	alpha-add-missing-dma_mapping_error.patch
> 	fix-compat-shmget-overflow.patch
> 	fix-shmget-for-ppc64-s390-64-sparc64.patch
> 	binfmt_elf-clearing-bss-may-fail.patch
> 	qlogic-warning-fixes.patch
> 	oprofile-exittext-referenced-in-inittext.patch
> 	force-read-implies-exec-for-all-32bit-processes-in-x86-64.patch
> 	oprofile-arm-xscale1-pmu-support-fix.patch
>...

As described in the patch description, I'd like to see 
mark-the-mcd-cdrom-driver-as-broken.patch in 2.6.11 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

