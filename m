Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284913AbRLZUo0>; Wed, 26 Dec 2001 15:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284902AbRLZUoR>; Wed, 26 Dec 2001 15:44:17 -0500
Received: from f133.law9.hotmail.com ([64.4.9.133]:27154 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S284913AbRLZUoF>;
	Wed, 26 Dec 2001 15:44:05 -0500
X-Originating-IP: [199.172.169.17]
From: "Arturas V" <arturasv@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: RE:  EEPro100 problems in SMP on 2.4.5 ?
Date: Wed, 26 Dec 2001 15:43:52 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1331RVM0t2CD7Lsb0O0001005d@hotmail.com>
X-OriginalArrivalTime: 26 Dec 2001 20:43:52.0486 (UTC) FILETIME=[07579C60:01C18E4E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi. While doing some file tranfers to our new server (a Compaq >Proliant 
>8way XEON 500 with 4gb ram and an EEPro100 NIC), the box socked sol (no 
>oops, no response via network, no response via console). The other 
> >hardware in the system was a Compaq Smart Array 9SMART2 driver). It's 
>running Slackware 7.1.

We had similar problems with Compaq Proliant XEON EEPro100 NIC and Compaq 
Spart Array. System would periodically hang or panic. Problems went away 
after I replaced EEPRO100 NIC with TLAN NICs(Texas instruments or 
"Thunderland"). It's a good indication that there could be a problem with 
eepro driver.
---
Arturas Vaitaitis.
---
Please CC: to arturasv@acedsl.com

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp.

