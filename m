Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269417AbRHWRzb>; Thu, 23 Aug 2001 13:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269390AbRHWRzV>; Thu, 23 Aug 2001 13:55:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60936 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269517AbRHWRzG>; Thu, 23 Aug 2001 13:55:06 -0400
Subject: Re: PDC20265 RAID signature
To: thockin@hockin.org (Tim Hockin)
Date: Thu, 23 Aug 2001 18:53:04 +0100 (BST)
Cc: arjanv@redhat.com, thockin@hockin.org (Tim Hockin),
        linux-kernel@vger.kernel.org
In-Reply-To: <200108231606.f7NG6Lu26772@www.hockin.org> from "Tim Hockin" at Aug 23, 2001 09:06:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZyfA-0004Ev-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any reason to use this RAID over the md RAID layer?  This still
> doesn't help me convince my BIOS to create a 4-disk array.  It will only
> create a 2 disk array..

As far as I can tell the drive array limits are wired into the bios, and
used to distinguish different product lines. 

Alan
