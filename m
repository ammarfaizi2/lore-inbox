Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277351AbRJOJOt>; Mon, 15 Oct 2001 05:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277349AbRJOJOk>; Mon, 15 Oct 2001 05:14:40 -0400
Received: from 217-79-101-244.adsl.griffin.net.uk ([217.79.101.244]:34925 "EHLO
	beast.ez-dsp.com") by vger.kernel.org with ESMTP id <S277347AbRJOJOZ>;
	Mon, 15 Oct 2001 05:14:25 -0400
Message-ID: <048a01c1555a$09d4e790$07fea8c0@stu2>
From: "James Stevenson" <mail-lists@stev.org>
To: "David Ford" <david@blue-labs.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3BC8A04A.5090108@blue-labs.org>
Subject: Re: Tcpdump filters, problem with UDP and 2.4.x
Date: Mon, 15 Oct 2001 10:16:13 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "David Ford" <david@blue-labs.org>
To: <linux-kernel@vger.kernel.org>
Sent: Saturday, October 13, 2001 9:12 PM
Subject: Tcpdump filters, problem with UDP and 2.4.x


> I see a lot of "UDP: bad checksum. ..." between two of my servers.  I
> haven't attached a tcpdump output of the packets because a) the packets
> between machine A and B travel through a GRE tunnel and b) does anyone
> have tcpdump filters or know how to finagle tcpdump into dumping the
> embedded packet instead of the GRE header'd packet?
>

id this for NFS udp traffic ?
if it is then you will see it i have seen this on both 2.2.x and 2.4.x
kernels
it only shows up on the nfs server side for me though.




