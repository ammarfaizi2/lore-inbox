Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVBUBks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVBUBks (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 20:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVBUBks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 20:40:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42421 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261192AbVBUBkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 20:40:40 -0500
Message-ID: <42193BFD.9070900@pobox.com>
Date: Sun, 20 Feb 2005 20:40:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/ne3210.c: cleanups
References: <20050218234659.GC4337@stusta.de>
In-Reply-To: <20050218234659.GC4337@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> -	if (ei_debug > 0)
> -		printk(version);


I agree the version variable is outdated, but I disagree that the driver 
intro banner should be removed completely.

	Jeff


