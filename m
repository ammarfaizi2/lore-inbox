Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUGYIQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUGYIQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 04:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUGYIQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 04:16:26 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:16133 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S263713AbUGYIQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 04:16:25 -0400
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: 3C905 and ethtool
Date: Sun, 25 Jul 2004 10:16:21 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200407251016.22001.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wanted to get info about my NIC via ethtool, but it writes:
# ethtool eth0
Cannot get device settings: Operation not supported
# ethtool eth1
Cannot get device settings: Operation not supported

00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 
30)
01:08.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]

Any possibility to add this support into this driver?

kernel 2.4.26-vanilla
Debian Woody

Thanks

Michal
