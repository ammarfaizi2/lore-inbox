Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbUKRVFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbUKRVFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUKRVAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:00:39 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:5596 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261165AbUKRVAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:00:00 -0500
Subject: Re: [PATCH] SCSI_QLOGIC_1280_1040 depends on SCSI_QLOGIC_1280
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411182143150.6824@anakin>
References: <Pine.LNX.4.61.0411182143150.6824@anakin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Nov 2004 14:59:42 -0600
Message-Id: <1100811588.2904.20.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 14:43, Geert Uytterhoeven wrote:
> SCSI_QLOGIC_1280_1040 depends on SCSI_QLOGIC_1280

A more comprehensive version of this is queued in the scsi-rc-fixes
tree:

http://linux-scsi.bkbits.net:8080/scsi-rc-fixes-2.6/cset@419a3a90hX7p5fl5hVBaLOHatSXnqA

James


