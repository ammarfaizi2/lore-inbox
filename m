Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266597AbUBLVDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 16:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266596AbUBLVDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 16:03:53 -0500
Received: from smtp13.eresmas.com ([62.81.235.113]:43423 "EHLO
	smtp13.eresmas.com") by vger.kernel.org with ESMTP id S266597AbUBLVDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 16:03:14 -0500
Message-ID: <402BEA0C.708@wanadoo.es>
Date: Thu, 12 Feb 2004 22:03:08 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.4.1) Gecko/20031114
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mbuesch@freenet.de
Subject: Re: lock up with 2.4.23
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:

> PSU? What's that?

Power Supply Unit.

And as usual:

- run memtest86+ [1] and cpuburn [2] to check the HW.
               ^
- update the firmware(MOBO BIOS, SCSI, hard disks, ...)
  to latest levels.


[1] http://www.memtest.org
[2] http://users.ev1.net/~redelm

