Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWAOSH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWAOSH5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 13:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWAOSH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 13:07:57 -0500
Received: from [81.2.110.250] ([81.2.110.250]:42218 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932139AbWAOSH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 13:07:56 -0500
Subject: Re: jsm serial driver broken with flip buffer changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Scott H Kilau <Scott_Kilau@digi.com>,
       Wendy Xiong <wendyx@us.ltcfwd.linux.ibm.com>
In-Reply-To: <Pine.SOC.4.61.0601142359120.15808@math.ut.ee>
References: <Pine.SOC.4.61.0601142359120.15808@math.ut.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 15 Jan 2006 18:11:54 +0000
Message-Id: <1137348715.2350.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-01-15 at 00:02 +0200, Meelis Roos wrote:
> In current 1.6.15+git jsm serial driver is broken:
> 
>    CC [M]  drivers/serial/jsm/jsm_tty.o

We know, thats why its marked broken. They've had considerable time to
fix it while the tty changes were in -mm.

Alan

