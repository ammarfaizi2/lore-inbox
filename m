Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132140AbRDPVS7>; Mon, 16 Apr 2001 17:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132146AbRDPVSu>; Mon, 16 Apr 2001 17:18:50 -0400
Received: from mail1.rdc2.ab.home.com ([24.64.2.48]:23695 "EHLO
	mail1.rdc2.ab.home.com") by vger.kernel.org with ESMTP
	id <S132140AbRDPVSg>; Mon, 16 Apr 2001 17:18:36 -0400
Message-ID: <3ADB608C.4D2E3ED5@home.com>
Date: Mon, 16 Apr 2001 15:13:48 -0600
From: swds.mlowe@home.com
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Slow LAN /w 2.4.3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've just switched from kernel 2.2.16 to 2.4.3 (because of a smbfs
bug). Anyways, all is well except for one little thing. Over the LAN in
2.2.16 I was getting around 900k/sec between the linux server and the
rest of the computers. After I upgraded I only get 200k/sec. I've
rebooted using 2.2.16 and all the sudden I get 900k/sec again. So, does
anyone know what's going on?

I've got two nics (Realtek PCI - External INet, Ehterlink III ISA -
LAN). I'm running Redhat 7.0, as well as ipchains.

Thanks,
  Matt

