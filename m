Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288544AbSA0UGG>; Sun, 27 Jan 2002 15:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288565AbSA0UFt>; Sun, 27 Jan 2002 15:05:49 -0500
Received: from [195.66.192.167] ([195.66.192.167]:17938 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288595AbSA0UFQ>; Sun, 27 Jan 2002 15:05:16 -0500
Message-Id: <200201272003.g0RK3sE20379@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Kudos to NFS developers
Date: Sun, 27 Jan 2002 22:03:56 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to say that when I decided to put my main Linux box on NFS I thought 
it wouldn't be painless. In fact, it was.

I am able to run a couple of workstations with shared NFS root fs (ro),
/usr (rw) and /home (rw). It works wonderfully over 100MBit eth and 
surprisingly good over 10MBit.

I rebooted NFS server on several occasions while clients were using it and 
witnessed that they handle this perfectly. No information is lost, apps just 
continue to happily run after server is up again.

I want to say big fat "THANK YOU!" to all NFS developers, testers and patch 
submitters!

Happy hacking!
--
vda
