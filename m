Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRKSIXS>; Mon, 19 Nov 2001 03:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274368AbRKSIXI>; Mon, 19 Nov 2001 03:23:08 -0500
Received: from mail016.syd.optusnet.com.au ([203.2.75.176]:64430 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S273622AbRKSIW5>; Mon, 19 Nov 2001 03:22:57 -0500
Message-ID: <001401c170d3$ea40cc10$1e50a8c0@kinslayer>
From: "Joel Beach" <joelbeach@optushome.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: Maximum (efficient) partition sizes for various filesystem types...
Date: Mon, 19 Nov 2001 19:26:40 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Have just put a new 30GB hard drive for my server at home, and am wondering
what the optimal sizes for partitioning are.

For instance, the Debian guide says that, due to Ext2 efficiency, partitions
greater than 6-7GB shouldn't be created. Is this true for Ext3/ReiserFS.

Am also not sure which file systems to choose. I'm planning on having a 3GB
parition for the actual system, and formatting this using ReiserFS
(generally smaller files). However, is Reiser also a good choice for
download archives (where average file size is about 5-10MB) still a good
choice?

Joel

