Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUCQAjx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 19:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbUCQAjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 19:39:53 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:25041 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261880AbUCQAjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 19:39:52 -0500
Message-ID: <40579E51.1000709@matchmail.com>
Date: Tue, 16 Mar 2004 16:39:45 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Status HPT374 (HighPoint 1540) Sata in 2.6
References: <405786EC.5000803@matchmail.com> <40578F31.5090700@matchmail.com> <405796B0.9070906@matchmail.com> <200403170127.33424.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403170127.33424.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> I think that it may work with drivers/ide/hpt366.c
> 
> AFAIK HPT374 is PATA only chipset and SATA support in HighPoint 1540
> is achieved by using PATA-SATA bridges.

Does that limit you to 133MB/s speeds?

And does that mean no hot-swap?
