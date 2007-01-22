Return-Path: <linux-kernel-owner+w=401wt.eu-S1751433AbXAVKCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXAVKCR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 05:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbXAVKCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 05:02:17 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:59344 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbXAVKCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 05:02:17 -0500
Date: Mon, 22 Jan 2007 11:02:12 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       =?ISO-8859-15?B?Qmr2cm4=?= Steinbrink <B.Steinbrink@gmx.de>,
       Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA exceptions triggered by XFS (since 2.6.18)
Message-ID: <20070122110212.11d2ed11@localhost>
In-Reply-To: <45B48549.1080209@gmail.com>
References: <20070121152932.6dc1d9fb@localhost>
	<20070121174023.68402ade@localhost>
	<45B3A392.6050609@shaw.ca>
	<20070121202552.14cc29fe@localhost>
	<45B42569.6030902@gmail.com>
	<20070122093823.1241be05@localhost>
	<45B48549.1080209@gmail.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2007 18:35:05 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Yeap, certainly.  I'll ask people first before actually proceeding with 
> the blacklisting.  I'm just getting a bit tired of tides of NCQ firmware 
> problems.
> 
> Anyways, for the time being, you can easily turn off NCQ using sysfs. 
> Please take a look at http://linux-ata.org/faq.html

ok

-- 
	Paolo Ornati
	Linux 2.6.20-rc5 on x86_64
