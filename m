Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933872AbWKTCe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933872AbWKTCe3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933871AbWKTCe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:34:29 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:50090 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S933861AbWKTCe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:34:28 -0500
Date: Sun, 19 Nov 2006 19:34:27 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [-mm patch] drivers/scsi/scsi_scan.c: make 2 functions static
Message-ID: <20061120023426.GL18567@parisc-linux.org>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061120022352.GH31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120022352.GH31879@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 03:23:52AM +0100, Adrian Bunk wrote:
> This patch makes two needlessly global functions static.

NAK, it's already in my scsi-async-scan tree which should be included
before the 2.6.20 merge.
