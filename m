Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVG1MAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVG1MAQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVG1MAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:00:16 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53266 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261404AbVG1MAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:00:14 -0400
Date: Thu, 28 Jul 2005 14:00:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: RFC: Raise required gcc version to 3.2 ?
Message-ID: <20050728120012.GB3528@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the oldest gcc we want to support in kernel 2.6?

Currently, it's 2.95 .

I'd suggest raising this to 3.2 which should AFAIK not be a problem for 
any distribution supporting kernel 2.6 .

Is there any good reason why we should not drop support for older 
compilers?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

