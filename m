Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032234AbWLGODO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032234AbWLGODO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032239AbWLGODN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:03:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1824 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1032234AbWLGODN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:03:13 -0500
Date: Thu, 7 Dec 2006 15:03:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: RFC: SOUND_TVMIXER still used?
Message-ID: <20061207140318.GH8963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

config SOUND_TVMIXER
        tristate "TV card (bt848) mixer support"
        depends on SOUND_PRIME && I2C && VIDEO_V4L1
        help
          Support for audio mixer facilities on the BT848 TV frame-grabber
          card.


Is this driver still used by anyone or can it be removed?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

