Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWAZWb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWAZWb2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWAZWb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:31:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44294 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964943AbWAZWb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:31:27 -0500
Date: Thu, 26 Jan 2006 23:31:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [2.6 patch: 0/10] remove ISA legacy functions
Message-ID: <20060126223126.GD3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains 8 patches by Al Viro to remove both usage and 
definition of the ISA legacy functions plus two additional cleanup 
patches.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

