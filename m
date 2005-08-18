Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVHRUhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVHRUhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 16:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVHRUhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 16:37:39 -0400
Received: from mail.dvmed.net ([216.237.124.58]:39129 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932139AbVHRUhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 16:37:38 -0400
Message-ID: <4304F173.6000108@pobox.com>
Date: Thu, 18 Aug 2005 16:37:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add PCI ID for GeForce 6200 TurboCache(TM)
References: <20050818202024.GK18386@cip.informatik.uni-erlangen.de>
In-Reply-To: <20050818202024.GK18386@cip.informatik.uni-erlangen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Glanzmann wrote:
> [PATCH] Add PCI ID for GeForce 6200 TurboCache(TM)
> 
> This adds the PCI ID for GeForce 6200 TurboCache(TM) as pointed out in
> ftp://download.nvidia.com/XFree86/Linux-x86/1.0-7676/README.txt
> 
> Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

Add this to the PCI IDs database as sourceforge.net.  The pci.ids files 
in the kernel is mirrored from that database, and also, it will soon be 
removed from the kernel itself.

	Jeff



