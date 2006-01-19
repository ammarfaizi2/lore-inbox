Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWASQ6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWASQ6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWASQ6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:58:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13330 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932460AbWASQ6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:58:35 -0500
Date: Thu, 19 Jan 2006 17:58:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
Message-ID: <20060119165832.GS19398@stusta.de>
References: <20060119030251.GG19398@stusta.de> <20060118194103.5c569040.akpm@osdl.org> <1137689071.4966.190.camel@dyn9047017102.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137689071.4966.190.camel@dyn9047017102.beaverton.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 08:44:31AM -0800, Badari Pulavarty wrote:
>...
> But again, its really useful to have raw driver to do simple "dd" tests
> to test raw performance for disks (for comparing with filesystems, block
> devices etc..). Without that, we need to add option to "dd" for
> O_DIRECT.

The oflag=direct option was added to GNU coreutils in version 5.3.0.

> Thanks,
> Badari

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

