Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263869AbUEMHbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbUEMHbQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 03:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbUEMHbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 03:31:16 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:22657 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S263869AbUEMHa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 03:30:59 -0400
Date: Thu, 13 May 2004 02:30:57 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Doug Maxey <dwm@austin.ibm.com>
cc: Bruce Allen <ballen@gravity.phys.uwm.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ppc64 HDIO_TASK_* ioctls 2.4, 2.6
In-Reply-To: <200405122209.i4CM9vqS013716@falcon10.austin.ibm.com>
Message-ID: <Pine.GSO.4.21.0405130226270.16230-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need a some guidance on enabling the ioctls on ppc64 to allow the
> smartmontools to run the appropriate set of commands. Does this look
> ok?  Have sniff tested, and the smart tools do run without ioctl
> errors.

Doug, "without ioctl errors" suggests that there might be *other* errors.  
If so, could you please write to smartmontools-support at lists dot sf dot
net about them?  We've tried hard to make and keep smartmontools both
64-bit and endian-order clean, but without test machines of all flavors we
rely on bug reports to keep us honest.

Cheers,
	Bruce

