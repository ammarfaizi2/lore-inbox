Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUCVSFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 13:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUCVSFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 13:05:21 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:3800 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261826AbUCVSFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 13:05:16 -0500
Date: Mon, 22 Mar 2004 20:05:13 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Shawn Starr <shawn.starr@rogers.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PANIC][2.6.5-rc2-bk1] st_probe - Detection of a SCSI tape drive
 (HP Colorado T4000s) - Dump included now
In-Reply-To: <000001c40fbd$add66100$030aa8c0@PANIC>
Message-ID: <Pine.LNX.4.58.0403222004170.1092@kai.makisara.local>
References: <000001c40fbd$add66100$030aa8c0@PANIC>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2004, Shawn Starr wrote:

> Here is the captured dump, the st driver appears to be broken:
> 
Please try 2.6.5-rc2-bk2, it includes a change that should fix this.

-- 
Kai
