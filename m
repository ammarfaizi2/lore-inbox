Return-Path: <linux-kernel-owner+w=401wt.eu-S1751828AbXAVAxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbXAVAxu (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 19:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbXAVAxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 19:53:50 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:46055 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828AbXAVAxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 19:53:49 -0500
Message-ID: <45B40B18.4090500@gmail.com>
Date: Mon, 22 Jan 2007 01:53:21 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Chr <chunkeey@web.de>
Cc: Paolo Ornati <ornati@fastwebnet.it>, Robert Hancock <hancockr@shaw.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jeff@garzik.org>,
       Tejun Heo <htejun@gmail.com>
Subject: Re: SATA exceptions triggered by XFS (since 2.6.18)
References: <20070121152932.6dc1d9fb@localhost> <45B3A392.6050609@shaw.ca> <20070121202552.14cc29fe@localhost> <200701212132.20099.chunkeey@web.de>
In-Reply-To: <200701212132.20099.chunkeey@web.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chr wrote:
>>   7 Seek_Error_Rate         0x000f   083   060   030    Pre-fail  Always       -       204305750
>>   1 Raw_Read_Error_Rate     0x000f   059   049   006    Pre-fail  Always       -       215927244
>> 195 Hardware_ECC_Recovered  0x001a   059   049   000    Old_age   Always       -       215927244 
> 
> Wow! that HDD is really in a bad condition.

I don't think so, this seems to be normal for Seagate drives...

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
