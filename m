Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932185AbWFDHE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWFDHE2 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 03:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWFDHE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 03:04:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10122
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932144AbWFDHE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 03:04:27 -0400
Date: Sun, 04 Jun 2006 00:04:25 -0700 (PDT)
Message-Id: <20060604.000425.21593578.davem@davemloft.net>
To: htejun@gmail.com
Cc: axboe@suse.de, James.Bottomley@SteelEye.com, davem@redhat.com,
        bzolnier@gmail.com, james.steward@dynamicratings.com,
        jgarzik@pobox.com, mattjreimer@gmail.com, g.liakhovetski@gmx.de,
        rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/5] arm: implement flush_kernel_dcache_page()
From: David Miller <davem@davemloft.net>
In-Reply-To: <44828384.1080906@gmail.com>
References: <1149392479281-git-send-email-htejun@gmail.com>
	<20060603.234517.104035250.davem@davemloft.net>
	<44828384.1080906@gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <htejun@gmail.com>
Date: Sun, 04 Jun 2006 15:53:56 +0900

> Yeap, HEAD and index got out of sync while fetching & checking out. 
> I've sent a regenerated patch as a reply to the original message. 
> Haven't you received it?

Yeah I saw it right after I wrote that email :)
