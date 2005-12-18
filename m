Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbVLRDfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbVLRDfR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 22:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbVLRDfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 22:35:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23311 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932690AbVLRDfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 22:35:16 -0500
Date: Sun, 18 Dec 2005 04:35:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Robert Walsh <rjwalsh@pathscale.com>, rolandd@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 03/13]  [RFC] ipath copy routines
Message-ID: <20051218033517.GY23349@stusta.de>
References: <200512161548.HbgfRzF2TysjsR2G@cisco.com> <200512161548.lRw6KI369ooIXS9o@cisco.com> <20051217123833.1aa430ab.akpm@osdl.org> <1134859243.20575.84.camel@phosphene.durables.org> <20051217191932.af2b422c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217191932.af2b422c.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 07:19:32PM -0800, Andrew Morton wrote:
>...
> In what form is this chip available?  As a standard PCI/PCIX card which
> people will want to plug into power4/ia64/x86 machines?  Or is it in some
> way exclusively tied to x86_64?

Hardware can hardly be exclusively tied to x86_64 without also being 
available on x86 machines since i386 kernels run on x86_64 hardware.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

