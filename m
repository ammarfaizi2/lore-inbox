Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWBSK43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWBSK43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 05:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWBSK43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 05:56:29 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:30664 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932395AbWBSK42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 05:56:28 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <0BF2E785-CC6D-4E4D-BDCF-AD21AEA10D36@bootc.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Chris Boot <bootc@bootc.net>
Subject: Driver 'w83627hf' needs updating - please use bus_type methods
Date: Sun, 19 Feb 2006 10:56:25 +0000
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just noticed the above message in my kernel log on my machine running  
2.6.16-rc2-ide2. I know there's a 2.6.16-rc4 now... I'm waiting to  
upgrade until Alan comes up with new -ide patches or ATAPI over  
libata/PATA starts working in -mm.

On another machine I also get:

Driver 'via686a' needs updating - please use bus_type methods

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


