Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266862AbUFYTWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266862AbUFYTWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266856AbUFYTWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:22:11 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:2202 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S266858AbUFYTVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:21:10 -0400
Date: Fri, 25 Jun 2004 15:15:02 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Sebastian Slota <SSlota@gmx.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Sil 3114 bug, 2.6.7
In-Reply-To: <27614.1088183146@www7.gmx.net>
Message-ID: <Pine.GSO.4.33.0406251506110.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.33.0406251506112.25702@sweetums.bluetronic.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, Sebastian Slota wrote:
>ata3: DMA timeout, stat 0x1
>ATA: abnormal status 0xD8 on port 0xF8B09287
...
>4x160GB SATA on Sil3114 as SCSI /dev/sda ..sdd

I'm guessing Seagate drives?  This is fixed in 2.6.7-bk7 and beyond.
(Your specific model drives may not be on the blacklist.)

--Ricky


