Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269287AbRHGStM>; Tue, 7 Aug 2001 14:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269288AbRHGStC>; Tue, 7 Aug 2001 14:49:02 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:4831 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S269287AbRHGSsy>; Tue, 7 Aug 2001 14:48:54 -0400
Date: Tue, 7 Aug 2001 14:49:01 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108071849.f77In1221907@devserv.devel.redhat.com>
To: oxymoron@waste.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Resources for SCSI, SRP, Infiniband?
In-Reply-To: <mailman.997195920.28446.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.997195920.28446.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also, anybody else looking at developing IB and or SRP?
> 
> The mention of all of the above together suggests you're working on iSCSI
> or something similar. If so, there are at least three open implementations
> for Linux, from Cisco, Intel, and UNH. Are you looking for Secure Remote
> Password (speced for iSCSI authentication) or Selective Retransmission
> Protocol?

Too many TLAs in the storage area. SRP in the context of Infi
is SCSI RDMA Protocol (formerly known as SCSI VI Protocol
(no, it is not Roman "six", but SCSI-over-VIA)). See:
 ftp://ftp.t10.org/t10/drafts/srp/srp-r07.pdf

-- Pete
