Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWAWAgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWAWAgD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 19:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWAWAgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 19:36:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10003 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932394AbWAWAgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 19:36:01 -0500
Date: Mon, 23 Jan 2006 01:36:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/coda/: proper prototypes
Message-ID: <20060123003600.GJ10003@stusta.de>
References: <20060121003517.GJ31803@stusta.de> <20060123001528.GC31997@delft.aura.cs.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123001528.GC31997@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 07:15:28PM -0500, Jan Harkes wrote:
> On Sat, Jan 21, 2006 at 01:35:17AM +0100, Adrian Bunk wrote:
> > This patch introduces a file fs/coda/coda_int.h with proper prototypes 
> > for some code.
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
>   Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>
> 
> Looks good. Is this going to be included in your cleanup patch series,
> or do you want me to forward it?

If you want you can forward it yourself.

Otherwise, I'll submit it through Andrew noting that it's 
maintainer-approved.

> Jan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

