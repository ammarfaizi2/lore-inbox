Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTDTRT4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 13:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263643AbTDTRT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 13:19:56 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:39651 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S263642AbTDTRTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 13:19:54 -0400
Date: Sun, 20 Apr 2003 13:28:22 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304201331_MC3-1-3532-FFDB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>   I buy three drives at a time so I have a matching spare, because AFAIC
>> you shouldn't be doing RAID on unmatched drives.
>
> Err, yes you should :-).
>
> Unless they are spindle syncronised, the advantage of identical
> physical layout diminishes, and the disadvantage of quite possibly
> getting components from the same, (faulty), batch increases :-).


 Yeah, I know, and some of my serial numbers are too close together
for comfort but I still like everything matched up:


hde: MAXTOR 4K060H3, ATA DISK drive
hdg: MAXTOR 4K060H3, ATA DISK drive
hdi: MAXTOR 4K060H3, ATA DISK drive
 hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 hde8 hde9 >
 hdg: hdg1 hdg2 hdg3 hdg4 < hdg5 hdg6 hdg7 hdg8 hdg9 >
 hdi: hdi1 hdi2 hdi3 hdi4 < hdi5 hdi6 hdi7 hdi8 hdi9 >



------
 Chuck
