Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVJINjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVJINjK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 09:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVJINjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 09:39:10 -0400
Received: from mail.dvmed.net ([216.237.124.58]:10652 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750707AbVJINjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 09:39:09 -0400
Message-ID: <43491D7A.4060705@pobox.com>
Date: Sun, 09 Oct 2005 09:39:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Currid <ACurrid@nvidia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc3] Fix sata_nv handling of NVIDIA MCP51/55
References: <8E5ACAE05E6B9E44A2903C693A5D4E8A091D1F10@hqemmail02.nvidia.com>
In-Reply-To: <8E5ACAE05E6B9E44A2903C693A5D4E8A091D1F10@hqemmail02.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Currid wrote:
> Patch to fix sata_nv handling of NVIDIA MCP51/55
> 
> 
> Signed-off-by: Andy Currid <acurrid@nvidia.com>
> 
> --- linux-2.6.14-rc3/drivers/scsi/sata_nv.c	2003-01-01
> 18:08:23.000000000 -0800
> +++ linux-2.6.14-rc3devel/drivers/scsi/sata_nv.c	2003-01-01
> 18:19:34.000000000 -0800

Applied, after I manually fixed the wrapped lines above.

	Jeff



