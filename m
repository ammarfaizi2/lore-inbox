Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbUBZH6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 02:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbUBZH6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 02:58:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23012 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262724AbUBZH6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 02:58:41 -0500
Message-ID: <403DA723.20304@pobox.com>
Date: Thu, 26 Feb 2004 02:58:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: akpm@osdl.org, linus@osdl.org, anton@samba.org, paulus@samba.org,
       axboe@suse.de, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
References: <20040123163504.36582570.sfr@canb.auug.org.au>	<20040122221136.174550c3.akpm@osdl.org>	<20040226172325.3a139f73.sfr@canb.auug.org.au>	<403DA056.8030007@pobox.com> <20040226185248.5cfce622.sfr@canb.auug.org.au>
In-Reply-To: <20040226185248.5cfce622.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> Hi Jeff,
> 
> Thanks for your comments, sorry I missed you first time around.
> 
> Firstly, even considering your comments below, would you object to
> the driver being included now and being fixed up later?

The locking and request-queue stuff needs to be fixed up first.

I don't mind if you put off the cosmetic/very-minor stuff.

	Jeff



