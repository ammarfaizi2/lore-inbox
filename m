Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVCYXVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVCYXVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 18:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVCYXVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 18:21:55 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7150 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261892AbVCYXVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 18:21:46 -0500
Subject: Re: How's the nforce4 support in Linux?
From: Lee Revell <rlrevell@joe-job.com>
To: Julien Wajsberg <julien.wajsberg@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2a0fbc59050325145935a05521@mail.gmail.com>
References: <2a0fbc59050325145935a05521@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 18:21:42 -0500
Message-Id: <1111792902.23430.34.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 23:59 +0100, Julien Wajsberg wrote:
> Mar 25 22:42:55 evenflow kernel: hda: dma_timer_expiry: dma status == 0x60
> Mar 25 22:42:55 evenflow kernel: hda: DMA timeout retry
> Mar 25 22:42:55 evenflow kernel: hda: timeout waiting for DMA
> Mar 25 22:42:55 evenflow kernel: hda: status error: status=0x58 {
> DriveReady SeekComplete DataRequest }
> Mar 25 22:42:55 evenflow kernel: 
> Mar 25 22:42:55 evenflow kernel: ide: failed opcode was: unknown
> Mar 25 22:42:55 evenflow kernel: hda: drive not ready for command
> Mar 25 22:42:55 evenflow kernel: hda: status timeout: status=0xd0 { Busy }
> Mar 25 22:42:55 evenflow kernel: 
> Mar 25 22:42:55 evenflow kernel: ide: failed opcode was: unknown
> Mar 25 22:42:55 evenflow kernel: hdb: DMA disabled
> Mar 25 22:42:55 evenflow kernel: hda: drive not ready for command

Are you sure the drive is OK?  Those messages are the classic signs of a
failing drive...

Lee

