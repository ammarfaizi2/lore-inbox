Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbSKHReR>; Fri, 8 Nov 2002 12:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbSKHReR>; Fri, 8 Nov 2002 12:34:17 -0500
Received: from fmr02.intel.com ([192.55.52.25]:60660 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S266839AbSKHReQ>; Fri, 8 Nov 2002 12:34:16 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A4D7@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'H. Peter Anvin'" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: RE: 2.4.20-rc1: oops in drivers/acpi/namespace/nswalk.c (with pat
	ch)
Date: Fri, 8 Nov 2002 09:40:50 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: H. Peter Anvin [mailto:hpa@zytor.com] 

> I have one machine which has been reliably oopsing in 
> drivers/acpi/namespace/nswalk.c -- this patch makes it work, 
> but I have 
> no idea why.  Either way, I thought someone would probably 
> want to look 
> at it.

Is this reproducible in 2.5.latest? If not, then it's fixed in the 2.4 ACPI
patch and is just awaiting merge.

Regards -- Andy
