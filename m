Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268464AbUHLIrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268464AbUHLIrY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 04:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268465AbUHLIrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 04:47:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1279 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268464AbUHLIrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 04:47:22 -0400
Date: Thu, 12 Aug 2004 10:47:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org, davem@redhat.com,
       netdev@oss.sgi.com
Subject: Re: [2.6 patch] atalk compile errors with SYSCTL=n
Message-ID: <20040812084717.GY26174@fs.tum.de>
References: <20040811224747.GQ26174@fs.tum.de> <20040811170101.69c140b6@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811170101.69c140b6@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 05:01:01PM -0700, Stephen Hemminger wrote:

> I prefer to have the CONFIG stuff in the header file.
> Here is an alternative that rearranges to put all function prototypes in atalk.h
> and stubs if necessary. It gets all the #ifdef CONFIG_ stuff out of the
> .c files.
>...

Compiles and looks good.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

