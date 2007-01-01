Return-Path: <linux-kernel-owner+w=401wt.eu-S1753674AbXAAW5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbXAAW5q (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 17:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753623AbXAAW5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 17:57:46 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:53986 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbXAAW5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 17:57:45 -0500
Message-ID: <45999191.8020004@gmail.com>
Date: Mon, 01 Jan 2007 23:56:17 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@oracle.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com>
In-Reply-To: <45998F62.6010904@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:

> In fact, it's CFQ. The PATA thing was a red herring. 2.6.20-rc2 and 3 
> give me ~ 24 MB/s from "hdparm t /dev/hda" while 2.6.20-rc1 and below 
> give me ~ 50 MB/s.
> 
> Jens: this is due to "[PATCH] cfq-iosched: tighten allow merge 
> criteria", 719d34027e1a186e46a3952e8a24bf91ecc33837:

axboe@oracle.com bounces for me. Could one of the other recipients of 
parent message try to forward?

Rene.
