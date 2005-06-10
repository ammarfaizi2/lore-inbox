Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVFJXFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVFJXFH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVFJXFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:05:06 -0400
Received: from [81.2.110.250] ([81.2.110.250]:28615 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261383AbVFJXDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:03:22 -0400
Subject: Re: MMC ioctl or sysfs interface?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <42A9FF79.1010003@drzeus.cx>
References: <42A83F59.7090509@drzeus.cx>
	 <101040.57feb9cd101d268ffd2ffe2d314867d3.ANY@taniwha.stupidest.org>
	 <42A9FF79.1010003@drzeus.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118444435.5213.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Jun 2005 00:00:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-06-10 at 22:00, Pierre Ossman wrote:
> >IDE disks can do this too --- is it the same interface?
> No. ATA and MMC are very different protocols.

It would be good to have the same ioctls on both block devices or sysfs
files however.

