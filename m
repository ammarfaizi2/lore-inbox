Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWBTAxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWBTAxp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWBTAxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:53:45 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18650 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751168AbWBTAxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:53:44 -0500
Subject: Re: Driver 'w83627hf' needs updating - please use bus_type methods
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Boot <bootc@bootc.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0BF2E785-CC6D-4E4D-BDCF-AD21AEA10D36@bootc.net>
References: <0BF2E785-CC6D-4E4D-BDCF-AD21AEA10D36@bootc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 19 Feb 2006 15:00:21 +0000
Message-Id: <1140361221.19213.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-02-19 at 10:56 +0000, Chris Boot wrote:
> Hi all,
> 
> Just noticed the above message in my kernel log on my machine running  
> 2.6.16-rc2-ide2. I know there's a 2.6.16-rc4 now... I'm waiting to  
> upgrade until Alan comes up with new -ide patches or ATAPI over  
> libata/PATA starts working in -mm.


There is a patch v -rc3 on the web site and I wouldn't be suprisd if it
applied easily to -rc4. I'll put out a new diff tomorrow some time,
which will also add the first bits of a promise 2024x/2026x driver for
the older boards.

Alan

