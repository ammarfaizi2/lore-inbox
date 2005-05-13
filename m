Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVEMNuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVEMNuL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 09:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVEMNuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 09:50:11 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59652 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262364AbVEMNuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 09:50:07 -0400
Date: Fri, 13 May 2005 15:50:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Clay Haapala <chaapala@cisco.com>
Cc: sri@us.ibm.com, lksctp-developers@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: SCTP: use lib/libcrc32c.c instead of net/sctp/crc32c.c?
Message-ID: <20050513135004.GG3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I understand it, lib/libcrc32c.c could be used instead of the 
similar code in net/sctp/crc32c.c .

Is there any reason why this isn't done?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

