Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVDQURr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVDQURr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVDQUNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:13:31 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:25351 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261481AbVDQULw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:11:52 -0400
Date: Sun, 17 Apr 2005 22:12:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Ladislav Michl <ladis@linux-mips.org>,
       James Chapman <jchapman@katalix.com>, sensors@stimpy.netroedge.com,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [2.6 patch] drivers/i2c/chips/ds1337.c: #if 0 an unused
 function
Message-Id: <20050417221202.7f54c58e.khali@linux-fr.org>
In-Reply-To: <20050417200056.GG3625@stusta.de>
References: <20050417200056.GG3625@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> This patch #if 0's an unused global function.

No. James and Ladislav are working on this driver.

Thanks,
-- 
Jean Delvare
