Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131825AbRAXPbI>; Wed, 24 Jan 2001 10:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132113AbRAXPa6>; Wed, 24 Jan 2001 10:30:58 -0500
Received: from smtp7.us.dell.com ([143.166.224.233]:8457 "EHLO
	smtp7.us.dell.com") by vger.kernel.org with ESMTP
	id <S131825AbRAXPaq>; Wed, 24 Jan 2001 10:30:46 -0500
Date: Wed, 24 Jan 2001 09:30:39 -0600 (CST)
From: Matt Domsch <Matt_Domsch@dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
To: I Lee Hetherington <ilh@sls.lcs.mit.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: No SCSI Ultra 160 with Adaptec Controller
In-Reply-To: <3A6EEA1B.87732D70@sls.lcs.mit.edu>
Message-ID: <Pine.LNX.4.30.0101240929310.16045-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>      /dev/sda:
>       Timing buffered disk reads:  64 MB in  1.59 seconds =40.25 MB/sec
>
> They can do more like 40MB/s, so only two disks could saturate the 80MB/s.

Apparently I was misinformed as to the speed of these disks.  My
apologies for the confusion this caused.
-Matt


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
