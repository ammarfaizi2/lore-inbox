Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268981AbRHFUOO>; Mon, 6 Aug 2001 16:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268989AbRHFUOE>; Mon, 6 Aug 2001 16:14:04 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:5764 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268981AbRHFUNs>; Mon, 6 Aug 2001 16:13:48 -0400
Date: Mon, 6 Aug 2001 16:13:58 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108062013.f76KDwI11220@devserv.devel.redhat.com>
To: mheinz@infiniconsys.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Resources for SCSI, SRP, Infiniband?
In-Reply-To: <mailman.997107541.5496.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.997107541.5496.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm making progress, but could someone direct me to a list of do's and 
> don't's for SCSI drivers in 2.4?

Laugh, sadly.

> Also, anybody else looking at developing IB and or SRP?

Nobody does IB in the open, because hardware is not generally
available. Adapter manufacturers roll their proprietary stacks.
I work in a Trillian style effort (e.g. definitely to be opensourced
at a later date) - contact johnsonm at redhat if you are interested
in joining.

No SRP implementations exist that I know of, prorotypes may
be out there, coming from storage startups. AFAIK, Intel is
using a packetised SCSI mapping, at least Ashok Raj made
noises about it on IDF.

-- Pete
