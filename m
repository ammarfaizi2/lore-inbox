Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290227AbSAXAXT>; Wed, 23 Jan 2002 19:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290229AbSAXAW7>; Wed, 23 Jan 2002 19:22:59 -0500
Received: from mpdr0.indianapolis.in.ameritech.net ([206.141.239.94]:58071
	"EHLO mailhost.ind.ameritech.net") by vger.kernel.org with ESMTP
	id <S290227AbSAXAWy>; Wed, 23 Jan 2002 19:22:54 -0500
Subject: rmap12a + performance boost
From: Bob Johnson <livewire_@ameritech.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 23 Jan 2002 19:21:16 -0500
Message-Id: <1011831677.3226.5.camel@Sorcerer>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just installed rmap12a with 2.4.17 vanilla on a

amd 1400mhz box 512 mem and 2 drives setup in

raid0. one a ata66 and the other ata100.


Getting the best tiobench and bonnie++ scores i can ever 
remember seeing. Ive tried all the other patches floating around
-aa, -mjc ,-ac2,etc

2.4.17 vanilla tiobench was around 40-44meg/sec

2.4.17-rmap12a tiobench 57meg/sec

                        Bob Johnson




