Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268722AbUH3SEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268722AbUH3SEL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUH3SDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:03:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20413 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268723AbUH3R77
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:59:59 -0400
Message-ID: <41336B0E.1090000@pobox.com>
Date: Mon, 30 Aug 2004 13:59:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata ATA vs SATA detection and workaround.
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com> <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com> <41321F7F.7050300@pobox.com> <41333CDC.5040106@wasp.net.au> <41334058.4050902@wasp.net.au> <413350A2.1000003@pobox.com> <41335723.40907@wasp.net.au> <413357AE.3000009@pobox.com> <41336141.7010407@wasp.net.au>
In-Reply-To: <41336141.7010407@wasp.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> Pretty new at kernel code. (And C for that matter)

Since you've been so helpful, I choose to disbelieve this ;-)


> I did note that it appears it's not going to do the right thing if we 
> have more than one device per host, but I guess thats not going to be an 
> issue for SATA for the near future anyway.
> 
> How's this grab you?

Looks perfect.

Confirm for me that it solves your problem, and I'll push it upstream.

	Jeff


