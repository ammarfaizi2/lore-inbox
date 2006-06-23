Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751976AbWFWUZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbWFWUZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbWFWUZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:25:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63152 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751976AbWFWUZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:25:35 -0400
Message-ID: <449C4E3C.7000107@garzik.org>
Date: Fri, 23 Jun 2006 16:25:32 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jordan Crouse <jordan.crouse@amd.com>
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       akpm@osdl.org
Subject: Re: [GIT PATCH] Geode patches for 2.6.17
References: <20060623170058.GA12819@cosmic.amd.com>
In-Reply-To: <20060623170058.GA12819@cosmic.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Crouse wrote:
> Hi - 
> 
> Please consider pulling from:
> git://git.infradead.net/users/jcrouse/geode.git linus-upstream
> 
> This is the new home for patches for the AMD Geode family of processors.
> 
> For 2.6.18, we offer up patches to support the One Laptop
> Per Child effort - namely framebuffer tweaks, plus an attempt to remove
> automagic probing of VGA registers (which we don't have on the OLPC
> platform).
> 
> Here is the shortlog:
> 
> Jordan Crouse:
>       GEODE: Update and fixup the PCI IDs for the CS5535
>       FB: Get the Geode GX frambuffer size from the BIOS
>       Add a configuration option to avoid automatically probing VGA
>       gxfb: Fixups for the AMD Geode GX framebuffer driver

When you send a 'please pull' message, two additional things are needed:
* output of 'diffstat -p1'
* the patches themselves, either in this email, or spread out across 
several emails in the same email thread (linked together with RFC822 
References header)

	Jeff



