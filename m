Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVHLTRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVHLTRj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVHLTRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:17:39 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:39192 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751251AbVHLTRi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:17:38 -0400
Message-ID: <42FCF5D3.1080409@danbbs.dk>
Date: Fri, 12 Aug 2005 21:17:39 +0200
From: Mogens Valentin <monz@danbbs.dk>
Reply-To: monz@danbbs.dk
Organization: Mr Dev
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux IDE Mailing List <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: SATA status report updated
References: <42FC2EF8.7030404@pobox.com>
In-Reply-To: <42FC2EF8.7030404@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Things in SATA-land have been moving along recently, so I updated the 
> software status report:
> 
>     http://linux.yyz.us/sata/software-status.html

 >> Queueing support, NCQ:
 >> #3 will be supported by libata, for all hardware and devices that
 >> support NCQ.

I guess this means libata support for HW-based NCQ.
It also could mean software/driver implemented NCQ, which could work on 
chipsets not supporting HW-NCQ in unison with a disk having NCQ?

> Although I have not updated it in several weeks, folks may wish to refer 
> to the hardware status report as well:
> 
>     http://linux.yyz.us/sata/sata-status.html

How well does libata work with the newest ULi chipsets?
If not well, is there a possible timeframe?


(not on kernel list; if anyone there comments on ULi, pls. cc private)

-- 
Kind regards,
Mogens Valentin

