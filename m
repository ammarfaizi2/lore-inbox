Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWFPTp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWFPTp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 15:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWFPTp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 15:45:56 -0400
Received: from lucidpixels.com ([66.45.37.187]:22657 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751481AbWFPTpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 15:45:55 -0400
Date: Fri, 16 Jun 2006 15:45:54 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
Subject: SATA ATA stat/err's again: rsync to SATA disk 2.6.16.20
Message-ID: <Pine.LNX.4.64.0606161545150.3548@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun 16 15:18:31 p34 kernel: [4369351.700000] ata3: translated ATA stat/err 
0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Jun 16 15:18:31 p34 kernel: [4369351.700000] ata3: status=0x51 { 
DriveReady SeekComplete Error }
Jun 16 15:18:31 p34 kernel: [4369351.700000] ata3: error=0x04 { 
DriveStatusError }

Under 2.6.16.20
I thought this got fixed? :-(

