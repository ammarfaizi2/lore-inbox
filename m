Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUA1NcA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 08:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUA1NcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 08:32:00 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:4068 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S265944AbUA1Nb6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 08:31:58 -0500
Date: Wed, 28 Jan 2004 14:31:23 +0100
From: Florian Engelhardt <dot@dot-matrix.de>
To: linux-kernel@vger.kernel.org
Subject: rio500 driver broken in linux 2.6.x
Message-Id: <20040128143123.69b6f281@HAL2000>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the rio500 driver seems to be broken, more and more people are talkin
about it. I allready wrote a mail to the maintainer of this dirver but
i got no response. The mailinglist which i found in the
/usr/src/linux/MAINTAINERS file is dead.
The Bug:
You con compile the driver without proplems, and when you connect the
rio500 to the usb bus, the kernel reports that he found it. But you can
not do any operations on it with the rio500 utils from sourceforge.
If i try to upload a file, or to create a folder on the rio500 the
connection to the player freezes and when i´m not killing the process,
the system hangs.
Does anyone of you know about this problem?
The problem depends on the new kernel, couse with the 2.4.x kernel there
are no problems with the rio utils from sourceforge.

Regards

Florian Engelhardt

-- 
[X] Nail here for a new monitor
