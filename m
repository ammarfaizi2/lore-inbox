Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVACImp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVACImp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 03:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVACImp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 03:42:45 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:22496 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261397AbVACImo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 03:42:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=mqw6fTxG6NrQ6rdRJYjioDNPUP+NRJ+VvzIiZ5gIZ+N3sBT7eoNIup6fJVL7deum9l8fBvGKY6ahb54G/Xp947ZJSs8kBVg4wCLgauWfG2n/5Lhcj7Z2PMdhRAireTtCKPh9Enoi9jWnIoLfiQ3H2yFI5bsdQyAFnawdlyGw8og=
Message-ID: <e453abbe05010300424d652b7a@mail.gmail.com>
Date: Mon, 3 Jan 2005 00:42:43 -0800
From: Daniel Robitaille <robitaille@gmail.com>
Reply-To: Daniel Robitaille <robitaille@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: CD-ROM ide-dma blacklist amnesty drive
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following is a list of CD drives blacklisted (I've removed
> hard-disks and flash from the list) in drivers/ide/ide-dma.c as
> of 2.6.10-rc3:
>
> CRD-8480C
>
> If (1) you are a owner of one of the listed drives, and (2) you
> know your drive works fine with DMA, please speak up.
> It would especially be a big plus if your drive is on via82cxxx
> and did not have any trouble running it with DMA before 2.6.8.

I have used a CRD-8480C with DMA on 2.6.8 without any problems.
