Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWEDNzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWEDNzq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 09:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWEDNzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 09:55:46 -0400
Received: from mserv2.uoregon.edu ([128.223.142.41]:3518 "EHLO
	smtp.uoregon.edu") by vger.kernel.org with ESMTP id S1750823AbWEDNzp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 09:55:45 -0400
Message-ID: <445A07D5.5010607@uoregon.edu>
Date: Thu, 04 May 2006 06:55:33 -0700
From: Joel Jaeggli <joelja@uoregon.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Yogesh Pahilwan <pahilwan.yogesh@spsoftindia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Generic SATA driver which works with Marvell SATA
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAA4EKnrx4E+kKrTaa+ZxzZDAEAAAAA@spsoftindia.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAA4EKnrx4E+kKrTaa+ZxzZDAEAAAAA@spsoftindia.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yogesh Pahilwan wrote:
> Hi Folks,
> 
> Is there any generic SATA driver available which should work with Marvell
> SATA disks? 

marvell sata controllers or sata disks with marvell sata-pata bridges?

There is an mv_sata driver for marvell controllers.

The disks shouldn't present a problem.

> Where can I download this driver?
> 
> Thanks,
> Yogesh
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
-------------------------------------------------
Joel Jaeggli (joelja@uoregon.edu)
GPG Key Fingerprint:
5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2
