Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbTEFQVQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263863AbTEFQTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:19:54 -0400
Received: from mail.convergence.de ([212.84.236.4]:4809 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263928AbTEFQN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:13:56 -0400
Message-ID: <3EB7D876.8050200@convergence.de>
Date: Tue, 06 May 2003 17:44:54 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH[[2.5][0-11] Update dvb-subsystem, dvb-drivers
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series of 11 patches syncs the http://www.linuxtv.org CVS with 2.5.69.

Most important items:
- update dvb subsystem core
- update dvb frontend drivers
- add a new frontend driver
- update the generic saa7146 driver
- update av7110 driver (saa7146 core user)
- update mxb and dpc7146 driver (saa7146 core user)
- update the firmware of the popular av7110 driver

Please review and apply.

Thanks
Michael Hunold.


