Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSFLD3p>; Tue, 11 Jun 2002 23:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSFLD3o>; Tue, 11 Jun 2002 23:29:44 -0400
Received: from ausxc10.us.dell.com ([143.166.98.229]:15890 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S317329AbSFLD3o>; Tue, 11 Jun 2002 23:29:44 -0400
Message-ID: <9A2D9C0E5A442340BABEBE55D81BEBDB012051FE@AUSXMPS313.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: jw@pegasys.ws, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] CONFIG_NR_CPUS, redux
Date: Tue, 11 Jun 2002 22:29:38 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I personally only rarely see 2-way boxes, 
> 4-way is pretty rare, and anything more must surely count as very
specialized.

A very large percentage of Dell PowerEdge servers sold with Red Hat Linux,
or used with other distros, have 2 or more processors.  We today have
servers with 1, 2, 4, or 8 CPUs, and with the advent of HyperThreading, that
looks like even more.  More than two CPUs is not at all uncommon in the
server space.  Desktop/notebook space, sure.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001! (IDC Mar 2002)
