Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269428AbTCDNVm>; Tue, 4 Mar 2003 08:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269430AbTCDNVm>; Tue, 4 Mar 2003 08:21:42 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:60557 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S269428AbTCDNVl>; Tue, 4 Mar 2003 08:21:41 -0500
Message-ID: <20030304133201.18619.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "David Anderson" <david-anderson2003@mail.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 04 Mar 2003 08:32:01 -0500
Subject: I/O Request [Elevator; Clustering; Scatter-Gather]
X-Originating-Ip: 133.145.164.4
X-Originating-Server: ws1-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I have been going through some documentation that talks of clustering, scatter-gather and elevator being used to improve performance. I am confused between these :

This is what I have understood :
Elevator
The job of the elevator is to sort I/O requests to disk drives in such a way that the disk head moving in the same direction for maximum performance. Have been able to locate the code for the same.

Clustering
Combines multiple requests to adjecent blocks into a single request. Have not been able to find the code which carries this out. Any clue on where this is done in the linux source code ??

Do Clustering of request and scatter-gather mean the same ?? Confused to the core... Kindly help me ...

Thanks and Regards,
David Anderson
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

