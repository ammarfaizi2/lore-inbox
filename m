Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266125AbSL1SqX>; Sat, 28 Dec 2002 13:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266173AbSL1SqX>; Sat, 28 Dec 2002 13:46:23 -0500
Received: from mkc-65-26-127-147.kc.rr.com ([65.26.127.147]:20499 "EHLO
	portal.home.hanaden.com") by vger.kernel.org with ESMTP
	id <S266125AbSL1SqW>; Sat, 28 Dec 2002 13:46:22 -0500
Message-ID: <3E0DF377.1070706@hanaden.com>
Date: Sat, 28 Dec 2002 12:54:47 -0600
From: Hanasaki JiJi <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Performance and Load Balancing in Dual Athlon Kernels?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How are processes, and multiple threads of a single process, balanced 
accross multiple processors?

part of the motivation is to determine what will run faster...
Dual Athlon 2400 with PC2100 memory - 760MPX Chips
	OR
Single Athlon 2400 with PC2700/3200 - KT400 Chips

There dont seem to be any boards for dual Athlon and the faster RAM.

some of the boards I am looking at are below.  Any specific comments are 
welcome.

Dual Athlon 2400MP and PC2100 - 760MPX
<MPX only supports PC2100>
Motherboards considered
     ASUS A7M266-D
     Tyan Thunder K7X (S2468)
     MSI K7D Master (MS-6501-030)
     Gigabyte GA7DPXDW+
     Gigabyte GA7DPDW-C

         VS

Single Athlon and PC2700 or PC3200 - KT400
<No motherboards found w/ fast RAM and dual cpu>
     ASUS A7V8X LAN
     Soyo SY-KT400 DRAGON Ultra
     Soyo SY-KT400 DRAGON Ultra (Platinum Edition)
     Gigabyte GA-7VAXP Ultra

nForce2
     ASUS A7N8X - PC3200/2700

Thanks.

