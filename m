Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUIWWFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUIWWFt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUIWWFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:05:21 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:34788 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267450AbUIWWEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:04:39 -0400
Subject: RE: 2.6.9-rc2-mm2: 3ware card info not in /proc/scsi
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Radford <aradford@amcc.com>
Cc: Glenn Johnson <gjohnson@srrc.ars.usda.gov>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <I4IDYU01.T3M@hadar.amcc.com>
References: <I4IDYU01.T3M@hadar.amcc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095973323.6735.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Sep 2004 22:02:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-23 at 20:24, Adam Radford wrote:
> There was so much dead code in the 3w-xxxx driver that it needed a major
> facelift for 2.6.  Otherwise it would eventually have been marked broken.
> As a part of the facelift, you must update your tools.  Nobody can guarantee
> future proofness of userspace tools that access low level kernel ioctls, 
> /proc entries, /sysfs entries, etc.  

Sure but thats a lot easier to manage when source code is available.
