Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130011AbQLTEdN>; Tue, 19 Dec 2000 23:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbQLTEdE>; Tue, 19 Dec 2000 23:33:04 -0500
Received: from quechua.inka.de ([212.227.14.2]:20024 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S130011AbQLTEcy>;
	Tue, 19 Dec 2000 23:32:54 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Cc: khaled@pacificpost.com
Subject: Re: Presentation Layer in TCP/IP linux implementation
Message-Id: <E148aSL-0001cH-00@calista.inka.de>
Date: Wed, 20 Dec 2000 05:02:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A3F57A0.32A6F34D@pacificpost.com> you wrote:
> Hello Linux World,

> Is there a way to add a generic and transparent presenation layer in the
> path of TCP/IP packets. I am speaking about something probably in the
> path between the user space mechanims (send/recv/read/write) and the
> actual sock_sendmsg/sock_recvmsg (and their proto counterparts).

In User mode you can use a dynamically pre-loaded lib, like socks is doing.

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
