Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVCVXw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVCVXw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVCVXw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:52:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59356 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261265AbVCVXws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:52:48 -0500
Message-ID: <4240AFC1.6050803@pobox.com>
Date: Tue, 22 Mar 2005 18:52:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/arcnet/: possible cleanups
References: <20050311181641.GK3723@stusta.de>
In-Reply-To: <20050311181641.GK3723@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - arcnet.c: kill the outdated VERSION

As I said WRT other drivers...  I don't like removing the printk completely.


> - arcnet.c: remove the unneeded EXPORT_SYMBOL(arc_proto_null)

why?

