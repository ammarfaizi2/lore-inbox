Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUCNVFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 16:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUCNVFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 16:05:23 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11242 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261615AbUCNVFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 16:05:13 -0500
Date: Sun, 14 Mar 2004 22:05:04 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>, John Stultz <johnstul@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.4-mjb1: No help text for VSYSCALL_GTOD
Message-ID: <20040314210504.GJ14833@fs.tum.de>
References: <23500000.1079289089@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23500000.1079289089@[10.10.2.4]>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 10:31:29AM -0800, Martin J. Bligh wrote:
>...
> New:
>...
> + vgtod1						John Stultz
> + vgtod2						John Stultz
> + vgtod3						John Stultz
> 	Vsyscall gettimeofday for ia32
>...

Please add a Kconfig help text for VSYSCALL_GTOD.

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

