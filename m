Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSENXuR>; Tue, 14 May 2002 19:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSENXuQ>; Tue, 14 May 2002 19:50:16 -0400
Received: from [65.219.148.17] ([65.219.148.17]:25736 "EHLO
	azog.l337hosting.com") by vger.kernel.org with ESMTP
	id <S316161AbSENXuQ> convert rfc822-to-8bit; Tue, 14 May 2002 19:50:16 -0400
Subject: ip addr add
Date: Tue, 14 May 2002 16:50:15 -0700
Message-ID: <FFAF1479E6949F4DAE87D09E1292D0376A62@azog.l337hosting.com>
X-MS-Has-Attach: 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
X-MS-TNEF-Correlator: 
Content-Transfer-Encoding: 8BIT
Thread-Topic: ip addr add
Thread-Index: AcH7oSZ0PFchVxY6TOmU0a/cL0A0bQ==
From: "Jason A. Ramsey" <jason@l337hosting.com>
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working with a RH7.3 box that has iproute2 installed. I am trying to
configure a slew of virtual interfaces on the server to accommodate
ip-based virtual hosting with Apache. I was led to believe that it was
possible to provision a group of addresses with a single command that
would cause the host to listen on all those addresses. I would like to
configure addresses 172.20.0.128-172.20.0.254 on the box without having
to manually specify every address. Is this possible? Thanks.

--

[jR]

there are no mistakes; only
happy accidents -- bob ross


