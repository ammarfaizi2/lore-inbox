Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWGTPsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWGTPsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWGTPsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:48:37 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58890 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030339AbWGTPsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:48:36 -0400
Date: Thu, 20 Jul 2006 17:48:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: RFC: remove include/linux/byteorder/pdp_endian.h
Message-ID: <20060720154834.GJ25367@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/byteorder/pdp_endian.h is completely unused, and the 
comment in the file itself states that it's both untested and a useless 
proof-of-concept.

Is there any serious reason for not removing it?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

