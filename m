Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274823AbRIZDw3>; Tue, 25 Sep 2001 23:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274825AbRIZDwT>; Tue, 25 Sep 2001 23:52:19 -0400
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:456 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S274823AbRIZDwN>; Tue, 25 Sep 2001 23:52:13 -0400
Message-ID: <009101c1463e$8410e160$1f33a8c0@ganga.wipro.com>
From: "Gangadhar Uppala" <gangadhar.uppala@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: How to exchange data between Kernel & User Space
Date: Wed, 26 Sep 2001 09:21:25 +0530
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi All,
    Here we are in need of a design decision . The problem is as follows:

We are writing device driver for network adapter, as part of this we need to
exchange some information between user and kernel(driver) and vice versa. As
i know this can be implemented using IOCTLs. Please suggest an alternative
approach for this.

Please keep a copy for me, because i am not subscriber to this list.

Thanks
Gangadhar


--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
