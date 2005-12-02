Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVLBUPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVLBUPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 15:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbVLBUPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 15:15:10 -0500
Received: from outmx009.isp.belgacom.be ([195.238.5.4]:60864 "EHLO
	outmx009.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751018AbVLBUPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 15:15:08 -0500
Subject: forcedeth
From: Jacques de Krahe <dekrahe@tiscali.be>
To: c-d hailfinger <linux-kernel@vger.kernel.org>
Cc: hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 21:09:51 +0100
Message-Id: <1133554191.4786.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running FC4 on a PC equipped with NForce2 chipset and AMD k7 (Athlon XP
2200) 
The eth interface can't be normally configured at boot and fails.
The problem comes from forcedeth. The system asks me to have a look into
dmesg, where I find a line that reads a follows: forcedeth : Unknown
parameter "irq"
The next line in /var/log/dmesg shows the version number.
Is it possible to correct the code and what are the necessary steps to
get a functional module?
If you answer my question, please be as complete as possible, I am a new
user of FC4.
Thank in advance
Regards
Jacques de Krahe

