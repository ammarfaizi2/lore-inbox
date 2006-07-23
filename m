Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWGWSnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWGWSnp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 14:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWGWSnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 14:43:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2067 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751267AbWGWSno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 14:43:44 -0400
Date: Sun, 23 Jul 2006 20:43:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: Andreas Gruenbacher <a.gruenbacher@computer.org>,
       James Morris <jmorris@redhat.com>, Nathan Scott <nathans@debian.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: include/linux/xattr.h: how much userpace visible?
Message-ID: <20060723184343.GA25367@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

how much of include/linux/xattr.h has to be part of the userspace kernel 
headers?

The function prototypes should no longer be visible in userspace.
But how much of the rest of this file is usable for userspace?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

