Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132912AbRDXJJk>; Tue, 24 Apr 2001 05:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132914AbRDXJJb>; Tue, 24 Apr 2001 05:09:31 -0400
Received: from [202.54.26.202] ([202.54.26.202]:28600 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S132909AbRDXJJW>;
	Tue, 24 Apr 2001 05:09:22 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: Rajeev Nigam <rajeev.nigam@dcmtech.co.in>
cc: linux-kernel@vger.kernel.org
Message-ID: <65256A38.0030A121.00@sandesh.hss.hns.com>
Date: Tue, 24 Apr 2001 14:28:19 +0530
Subject: Re: Delay Function
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It may be possible that this is not the good choice...
but u can try ... schedule_timeout(timeout) function.... see kernel/sched.c for
more details about this function

Amol





Rajeev Nigam <rajeev.nigam@dcmtech.co.in> on 04/24/2001 03:29:04 PM

To:   linux-kernel@vger.kernel.org
cc:    (bcc: Amol Lad/HSS)

Subject:  Delay Function




What function i have to use to put a delay in a driver at kernel mode
between reading from and writing to com port.

Looking forward for ur help.

Thanx & Regards
Rajeev Nigam
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




