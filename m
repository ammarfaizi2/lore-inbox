Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbUBXDcI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 22:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbUBXDcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 22:32:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61391 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262143AbUBXDcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 22:32:05 -0500
Message-ID: <403AC5A8.4090909@pobox.com>
Date: Mon, 23 Feb 2004 22:31:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Phillips <phillim2@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3c359_microcode.h clean up - 2.6.3
References: <20040224030933.GA7116@siasl.dyndns.org>
In-Reply-To: <20040224030933.GA7116@siasl.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Phillips wrote:
> Small patch to clean up 3c359_micrcode.h, no other drivers in the kernel
> come anywhere near the file and the #if is superflous.
> 
> Mike Phillips 
> 
> diff -urN -X dontdiff linux-2.6.3/drivers/net/tokenring/3c359_microcode.h linux-2.6.3-working/drivers/net/tokenring/3c359_microcode.h
> --- linux-2.6.3/drivers/net/tokenring/3c359_microcode.h	2004-02-17 22:57:20.000000000 -0500
> +++ linux-2.6.3-working/drivers/net/tokenring/3c359_microcode.h	2004-02-23 21:57:58.000000000 -0500


I'll throw this in...

	Jeff



