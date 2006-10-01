Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWJAUNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWJAUNK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 16:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWJAUNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 16:13:10 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:48059 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932287AbWJAUNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 16:13:09 -0400
Message-ID: <45202141.3010304@verkstad.net>
Date: Sun, 01 Oct 2006 22:12:49 +0200
From: Theo Kanter <theo@verkstad.net>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.18 PATA support for sata_promise not working for PDC20378
 on MSI 865PE-NEO FISR2 motherboard
References: <45201943.7050408@verkstad.net> <45201E98.5030104@garzik.org>
In-Reply-To: <45201E98.5030104@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Theo Kanter wrote:
>> Kernel 2.6.18 claims to provide PATA support for sata_promise 
>> according to the changelog.
> Which changelog?  I assure you (a) PATA support for sata_promise is 
> not in 2.6.18, and (b) it implies nothing of the sort in the official 
> kernel changelog on ftp.kernel.org.
Thanks Jeff for a quick response. Well, it is only because 
http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.18 mentions 
the following:

    Author: Jeff Garzik <jeff@garzik.org>
    Date:   Wed May 24 01:43:25 2006 -0400
        [libata sata_promise] Add PATA cable detection.
        Original patch from Phillip Jordan <phillip.m.jordan@gmail.com>
        Cleanups and fixes by me.

Does this mean something other than that sata_promise actually provides 
support for PATA or how should I interpret this? Also, with respect to 
the error messages in my previous messages, could you please advise me 
about my options? (e.g., wait for a new kernel, etc.)?

Thanks,
Theo


