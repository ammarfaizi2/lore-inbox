Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290561AbSAYFzX>; Fri, 25 Jan 2002 00:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290573AbSAYFzG>; Fri, 25 Jan 2002 00:55:06 -0500
Received: from beasley.gator.com ([63.197.87.202]:57609 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S290561AbSAYFyx>; Fri, 25 Jan 2002 00:54:53 -0500
From: "George Bonser" <george@gator.com>
To: <timothy.covell@ashavan.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux console at boot
Date: Thu, 24 Jan 2002 21:54:51 -0800
Message-ID: <CHEKKPICCNOGICGMDODJAEPEGBAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <200201250550.g0P5o1L09511@home.ashavan.org.>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not until after it boots and it never boots. Actually, the problem is
it never sees the disk.

I need to stop the bootup process or somehow hang the screen. Scroll
lock and xoff (^S) do not do anything.


> you can get this info via "dmesg"
>
> --
> timothy.covell@ashavan.org.

