Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282877AbRLBNxF>; Sun, 2 Dec 2001 08:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278690AbRLBNw4>; Sun, 2 Dec 2001 08:52:56 -0500
Received: from wiproecmx2.wipro.com ([164.164.31.6]:16636 "EHLO
	wiproecmx2.wipro.com") by vger.kernel.org with ESMTP
	id <S278428AbRLBNwo>; Sun, 2 Dec 2001 08:52:44 -0500
Message-ID: <006801c17b39$e4344e30$4e05720a@M3HOM103042>
From: "Venkata Rajesh Velamakanni" <rajesh.venkata@wipro.com>
To: <linux-kernel@vger.kernel.org>
Subject: Regaring Routing Socket support in Linux kernel.
Date: Sun, 2 Dec 2001 19:31:51 +0530
Organization: Wipro Ltd.
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello All,

This is regarding query on AF_ROUTE sockets on Linux.

I would like to know whether Linux supports AF_ROUTE
sockets or one should use NETLINK sockets or does linux
support both. 

( In the file linux/socket.h there is comment saying
#define AF_ROUTE  AF_NETLINK  /* Alias to emulate 4.4 BSD */ )


Thanks,
Rajesh.




--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

-----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
------------------------------------------------------------------------------------------------------------------------

--------------InterScan_NT_MIME_Boundary--
