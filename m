Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312121AbSCQUn0>; Sun, 17 Mar 2002 15:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312120AbSCQUnR>; Sun, 17 Mar 2002 15:43:17 -0500
Received: from ns.suse.de ([213.95.15.193]:34318 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312119AbSCQUm6>;
	Sun, 17 Mar 2002 15:42:58 -0500
Date: Sun, 17 Mar 2002 21:42:56 +0100
From: Dave Jones <davej@suse.de>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.6-dj1
Message-ID: <20020317214256.C5010@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3C94E400.99DCBC12@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C94E400.99DCBC12@torque.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 01:44:16PM -0500, Douglas Gilbert wrote:

 > Compiled here but didn't link (SMP) :-(
 >  page_cache_release undefined multiple times in mm/mm.o

 Probably a side-effect of me removing the radix tree patch.
 I'll look into this.

 > There are over 30 scsi subsystem patches backed up in
 > your tree. Some are over 2 months old. Could
 > some (or perhaps all) of them get promoted to the
 > main tree? 

 Indeed. Once Linus returns from vacation, I'll be doing a
 patch-bombing on a larger scale than usual 8-)

 Any bits I'm uncertain of, I'll bounce your way first for
 clarification, deal ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
