Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286603AbSABCHY>; Tue, 1 Jan 2002 21:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286606AbSABCHO>; Tue, 1 Jan 2002 21:07:14 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:2009 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S286603AbSABCHK>; Tue, 1 Jan 2002 21:07:10 -0500
Date: Tue, 1 Jan 2002 21:07:09 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200201020207.g02279405713@devserv.devel.redhat.com>
To: nahshon@actcom.co.il, linux-kernel@vger.kernel.org
Subject: Re: SCSI host numbers?
In-Reply-To: <mailman.1009934881.4099.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1009934881.4099.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Under some scenarios Linux assigns the same
> host_no to more than one scsi device.

> Similar bug reported also to redhat. See:
> http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=55876

Curious, I'll look into it.

-- Pete
