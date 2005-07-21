Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVGULxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVGULxa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 07:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVGULxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 07:53:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15876 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261762AbVGULwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 07:52:33 -0400
Date: Thu, 21 Jul 2005 13:52:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org
Subject: -mm: strange places for the PERFCTR option
Message-ID: <20050721115225.GA3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On i386, the PERFCTR option is currently available under:

  Power management options (ACPI, APM)
    APM (Advanced Power Management) BIOS Support


On x86_64, the PERFCTR option is currently available under:

  Executable file formats / Emulation


On ppc, the PERFCTR option is currently available under:

  Processor


On ppc64, the PERFCTR option is currently available under:

  Platform support


The ppc and ppc64 places seem to be logical, but the places where it's 
available on i386 and x86_64 are strange.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

