Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbUKXWHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbUKXWHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 17:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbUKXWHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 17:07:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48645 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262765AbUKXWHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:07:47 -0500
Date: Wed, 24 Nov 2004 23:07:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: 2.6: sound/isa/gus/gus_lfo.c is unused
Message-ID: <20041124220742.GL19873@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaroslav,

in kernel 2.6 (I've checked 2.6.10-rc2-mm3), the file 
sound/isa/gus/gus_lfo.c is completely unused (it's never built, and all 
code using it in other files is #if 0'ed).

What's the status of this file?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

