Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWCSV7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWCSV7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 16:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWCSV7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 16:59:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51718 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751107AbWCSV7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 16:59:45 -0500
Date: Sun, 19 Mar 2006 22:59:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: info-linux@geode.amd.com
Cc: linux-kernel@vger.kernel.org
Subject: Why doesn't MGEODE_LX enable X86_TSC?
Message-ID: <20060319215943.GH14608@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the AMD data books for the Geode GX and Geode LX processors
they seem to have a time stamp counter.

Is it accidental that CONFIG_MGEODE_LX doesn't enable CONFIG_X86_TSC or 
is there a reason for this?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

