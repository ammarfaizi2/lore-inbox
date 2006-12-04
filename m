Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937037AbWLDQEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937037AbWLDQEa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937053AbWLDQEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:04:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2752 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S937037AbWLDQEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:04:30 -0500
Date: Mon, 4 Dec 2006 17:04:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: George Talusan <gstalusan@uwaterloo.ca>, perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: sound/isa/cmi8330.c: dead ENABLE_SB_MIXER code
Message-ID: <20061204160434.GF30290@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In sound/isa/cmi8330.c, the ENABLE_SB_MIXER code is currently never 
used.

What's the story behind this?
Should ENABLE_SB_MIXER be enabled?
Or the code be removed?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

