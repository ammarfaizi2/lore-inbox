Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317686AbSGRJsc>; Thu, 18 Jul 2002 05:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316848AbSGRJsc>; Thu, 18 Jul 2002 05:48:32 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:29081 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317780AbSGRJsb>; Thu, 18 Jul 2002 05:48:31 -0400
Date: Thu, 18 Jul 2002 12:08:41 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: NFS can't get request (2.5.26)
Message-ID: <Pine.LNX.4.44.0207181207230.29012-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

I got the following after trying to do tab completion in an NFS fs, and 
straight afterwards on another console df(1).  the client finally 
recovered though.

nfs: task 626 can't get a request slot
nfs: task 627 can't get a request slot
nfs: server montezuma OK
nfs: server montezuma OK

Cheers,
	Zwane Mwaikambo
-- 
function.linuxpower.ca

