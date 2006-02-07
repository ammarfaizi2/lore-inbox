Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbWBGMwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbWBGMwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbWBGMwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:52:32 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:53658 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S965063AbWBGMwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:52:31 -0500
To: linux@picadreams.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Development of Ricoh Memory Host Adapter
In-Reply-To: <200602071128.16673.linux@picadreams.com>
References: <200602071128.16673.linux@picadreams.com>
Date: Tue, 7 Feb 2006 12:52:25 +0000
Message-Id: <E1F6SKX-00011c-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nassian <linux@picadreams.com> wrote:

> Because there is no module for the Ricoh Memory Host Adapter, which is in my 
> notebook, I want to start developing one.
> 00:0a.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 
> 17)

There's already a driver for the SD/MMC portion of this - see
http://mmc.drzeus.cx/wiki/Linux/Drivers/sdhci .

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
