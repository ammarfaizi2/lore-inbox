Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264650AbUEJMFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbUEJMFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUEJMFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:05:39 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:2998 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S264650AbUEJMFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:05:38 -0400
Message-ID: <409F6FB4.50608@keyaccess.nl>
Date: Mon, 10 May 2004 14:04:04 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
References: <409F4944.4090501@keyaccess.nl> <200405100732.10363.gene.heskett@verizon.net>
In-Reply-To: <200405100732.10363.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>> hda: Maxtor 6Y120P0, ATA DISK drive

> I note the drive is the same model here too, Rene.
> 
> The question remains however, is our data in danger?

There's a fair change that we'll be told, yes, very much so, since these 
drives don't seem to correctly support this life saving feature. The 
real answer though will be more easily deducted by calculating the ratio 
of unexplained file system corruptions you've had and reboots you've 
managed (0, that is).

Rene.



