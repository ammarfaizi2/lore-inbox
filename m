Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVFUOmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVFUOmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVFUOlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:41:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61448 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262082AbVFUOkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:40:43 -0400
Date: Tue, 21 Jun 2005 16:40:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: ALSA: Is CONFIG_SND_DEBUG_MEMORY really required?
Message-ID: <20050621144041.GP3666@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was a bit surprised to discover that ALSA has it's own memory 
debugging infrastructure.

Is there a reason why CONFIG_DEBUG_SLAB isn't good enough for ALSA?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

