Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbTDJVYe (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTDJVYe (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:24:34 -0400
Received: from mail1.ewetel.de ([212.6.122.16]:28850 "EHLO mail1.ewetel.de")
	by vger.kernel.org with ESMTP id S264173AbTDJVYd (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:24:33 -0400
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATAPI cdrecord issue 2.5.67
In-Reply-To: <20030410205020$3813@gated-at.bofh.it>
References: <20030410143018$100e@gated-at.bofh.it> <20030410144011$6cc1@gated-at.bofh.it> <20030410150015$0682@gated-at.bofh.it> <20030410194019$3cf5@gated-at.bofh.it> <20030410200011$156b@gated-at.bofh.it> <20030410205020$3813@gated-at.bofh.it>
Date: Thu, 10 Apr 2003 23:36:07 +0200
Message-Id: <E193jiK-00057T-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Apr 2003 22:50:20 +0200, you wrote:
> On Thu, 2003-04-10 at 20:53, H. Peter Anvin wrote:
>> I think ide-scsi needs to be supported for some time going forward.
>> After all, cdrecord, cdrdao, dvdrecord aren't going to be the only
>> applications.
> 
> And far longer than that. People seem to be testing and demoing 
> crazy things like SATA attached scanners, printers and even enclosure
> services.

Just to add to the list, I have an ATAPI MO drive that only works with
ide-scsi and not with any native IDE driver.

hde: FUJITSU MCC3064AP, ATAPI OPTICAL drive
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: FUJITSU   Model: M25-MCC3064AP     Rev: 0051
  Type:   Optical Device                     ANSI SCSI revision: 02

-- 
Ciao,
Pascal
