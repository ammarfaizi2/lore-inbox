Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSCWBRV>; Fri, 22 Mar 2002 20:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290965AbSCWBQ6>; Fri, 22 Mar 2002 20:16:58 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:62955 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S310436AbSCWBPv>; Fri, 22 Mar 2002 20:15:51 -0500
Message-Id: <5.1.0.14.2.20020322170653.0337b970@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 22 Mar 2002 17:15:02 -0800
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: [PATCH] Updated ATM patch for 2.4.19-pre4
Cc: marcelo Tosatti <marcelo@conectiva.com.br>, Alan@lxorguk.ukuu.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, Alan,

I updated ATM patch for 2.4.19-pre4. It includes couple of fixes that I 
missed in my first patch
and includes ATM Ethernet bridging support (RFC2684) implemented by Marcell 
GAL.
It is rather big for email. Here is the URL:
         http://bluez.sourceforge.net/patches/atm.patch-2.4.19-pre4.gz

Please apply.
Thanks



Max

http://bluez.sf.net
http://vtun.sf.net

