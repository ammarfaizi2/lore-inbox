Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267588AbSLFUTb>; Fri, 6 Dec 2002 15:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267590AbSLFUTb>; Fri, 6 Dec 2002 15:19:31 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:19375 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267588AbSLFUTa>; Fri, 6 Dec 2002 15:19:30 -0500
Subject: Re: [PATCH] Initio 9100-U SCSI Driver. ini9100u.c ini9100u.h
	[KERNEL 2.5.50]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Aaron Baxter <abaxter@southernohio.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212061355.33462.abaxter@southernohio.net>
References: <200212061355.33462.abaxter@southernohio.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 21:02:27 +0000
Message-Id: <1039208548.22971.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-06 at 18:55, Aaron Baxter wrote:
> I'm unsure who is responsible for maintain this driver but I've seldom seen 
> manufactures support beta OSes. If someone could look into this it would be 
> great (or maybe someone already fixed it). I would appreciate any feedback I 
> could get as I would like to have this contributed to the kernel package (if 
> needed).

The reset locking and returns hav changed - that isnt enough Im afraid

