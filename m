Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVGQEFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVGQEFc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 00:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVGQEFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 00:05:31 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:40528 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261930AbVGQEF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 00:05:28 -0400
Date: Sat, 16 Jul 2005 21:04:56 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: bunk@stusta.de, andrew.vasquez@qlogic.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Subject: Re: [2.6 patch] SCSI_QLA2ABC mustn't select SCSI_FC_ATTRS
Message-Id: <20050716210456.12accf7b.rdunlap@xenotime.net>
In-Reply-To: <1121569886.13990.4.camel@mindpipe>
References: <20050715013653.36006990.akpm@osdl.org>
	<20050715102744.GA3569@stusta.de>
	<20050715144037.GA25648@plap.qlogic.org>
	<20050717023809.GE3613@stusta.de>
	<1121569886.13990.4.camel@mindpipe>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2005 23:11:26 -0400 Lee Revell wrote:

> On Sun, 2005-07-17 at 04:38 +0200, Adrian Bunk wrote:
> > SCSI_QLA2XXX is automatically enabled for (SCSI && PCI).
> 
> This has bugged me for a while.  Why does this one SCSI driver default
> to Y in the first place?

It's not a driver, it's a subdirectory.

---
~Randy
