Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277861AbRJNVIz>; Sun, 14 Oct 2001 17:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277857AbRJNVIp>; Sun, 14 Oct 2001 17:08:45 -0400
Received: from kc-msxalone.kc.umkc.edu ([134.193.143.157]:4371 "EHLO
	kc-msxalone.kc.umkc.edu") by vger.kernel.org with ESMTP
	id <S277790AbRJNVIg> convert rfc822-to-8bit; Sun, 14 Oct 2001 17:08:36 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Subject: network device driver
Date: Sun, 14 Oct 2001 16:09:08 -0500
Message-ID: <F918702592382F4991EB852F78EF36583203A3@KC-MAIL2.kc.umkc.edu>
Thread-Topic: network device driver
Thread-Index: AcFU9HahH3qedi0kShqkDgyNb0S0Hg==
From: "Mehta, Phoram Kirtikumar (UMKC-Student)" <pkm722@umkc.edu>
To: <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Oct 2001 21:09:08.0834 (UTC) FILETIME=[77003420:01C154F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
1. how does ifconfig and netstat get teh net statistics, where can i get
the source to that funtion or source file.
2. is there any funtion in the network device driver source by accessing
which i can get the packets received or the type of packets. if not can
anybody gimme some tips on how can i write it.

i am trying to write or modify the eth device driver(3c509.c) in such a
way that i can statistics of the traffic and then i also want to
identify teh traffic. in short i want to incorporate a function in my
driver which when acceseed would act as a sniffer/protocol analyzer .
any help or advise will be appreciated.

thanks,
phoram mehta
