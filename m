Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVCFXVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVCFXVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVCFXT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:19:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8455 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261591AbVCFWmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:42:03 -0500
Date: Sun, 6 Mar 2005 23:41:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: 2.6: sound/isa/gus/gus_lfo.c is unused (fwd)
Message-ID: <20050306224159.GQ5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaroslav,

I didn't receive any answer regarding this question.

Any comments or shall I send a patch to remove this file?

cu
Adrian


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Wed, 24 Nov 2004 23:07:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: 2.6: sound/isa/gus/gus_lfo.c is unused

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

