Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWHZWY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWHZWY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 18:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWHZWY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 18:24:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52866 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751228AbWHZWY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 18:24:26 -0400
Subject: Re: wrt: dma_intr: status=0x51 { DriveReady SeekComplete Error }
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter <sw98234@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ecpru4$9t3$1@sea.gmane.org>
References: <ecpru4$9t3$1@sea.gmane.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 26 Aug 2006 23:46:05 +0100
Message-Id: <1156632365.3007.298.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-08-26 am 16:12 +0000, ysgrifennodd Peter:
> 2) VMWare. I have noticed recently that the errors are occurring during or
> after VMWare is run.

Then please report them to the vmware people unless you can reproduce it
from a clean boot which never touched vmware or loaded any vmware
modules.

The only real way this error can occur other than hardware is if
something crapped on the drive configuration. If it is triggered by
vmware you know who to talk to 8)

