Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVC2IKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVC2IKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbVC2HZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:25:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21436 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262472AbVC2HGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:06:03 -0500
Message-ID: <4248FE3C.6030906@pobox.com>
Date: Tue, 29 Mar 2005 02:05:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] slab: kfree(null) is unlikely
References: <200503290507.j2T57k3U017427@hera.kernel.org>
In-Reply-To: <200503290507.j2T57k3U017427@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.2231.1.8, 2005/03/28 19:18:25-08:00, akpm@osdl.org
> 
> 	[PATCH] slab: kfree(null) is unlikely
> 	
> 	- mark kfree(NULL) as being unlikely

This is just a wild guess, right?

Seems to me, it depends on the code.

	Jeff


