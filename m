Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVACLpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVACLpM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 06:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVACLpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 06:45:12 -0500
Received: from mx2.na.infn.it ([192.84.134.182]:64182 "EHLO mx2.na.infn.it")
	by vger.kernel.org with ESMTP id S261424AbVACLpI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 06:45:08 -0500
From: Antonio de Candia <decandia@na.infn.it>
To: linux-kernel@vger.kernel.org
Subject: Tyan Thunder K7X Pro Ethernet Card
Date: Mon, 3 Jan 2005 12:44:57 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200501031244.58929.decandia@na.infn.it>
X-PMX-Version: 4.7.0.111621, Antispam-Engine: 2.0.1.0, Antispam-Data: 2005.1.2.35
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CD 0, __CT 0, __CTE 0, __CTYPE_CHARSET_QUOTED 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I have an APPRO node with Tyan Thunder K7X Pro (S2469)
motherboard.
It has two onboard Ethernet controllers, 
    - Intel® 82545EM 10/100/1000Mbps controller
    - Intel® 82551QM 10/100Mbps controller
(as stated on www.tyan.de)
I installed Linux Slackware 10.0, and used the modules
e1000 and e100 for the two ethernet cards...
The first eth0 works well with the e1000 driver, but 
eth1 with e100 does not work... if I scp a big file,
after transmitting some megabytes it hangs (scp says
"-- stalled --")
The same happens with http transfers...
I tried also with eepro100 driver, but nothing changes...

Thank you very much for any help
