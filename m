Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVGBXlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVGBXlx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 19:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVGBXlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 19:41:53 -0400
Received: from unknown.ghostnet.de ([217.69.161.74]:30106 "EHLO nexave.de")
	by vger.kernel.org with ESMTP id S261330AbVGBXl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 19:41:29 -0400
Message-ID: <42C725E5.8020405@cyberoptic.de>
Date: Sun, 03 Jul 2005 01:40:21 +0200
From: CyberOptic <mail@cyberoptic.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Coady <grant_lkml@dodo.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: ppa / parport zip-drive / kernel 2.6.12.2 [RESOLVED]
References: <42C6FD00.2060408@cyberoptic.de> <1a3ec1t4evi7dcops742493hv7vd9aijb5@4ax.com> <42C71353.3000802@cyberoptic.de> <4g5ec1pftrkmejqs3rdl8lms2j49a7duhp@4ax.com>
In-Reply-To: <4g5ec1pftrkmejqs3rdl8lms2j49a7duhp@4ax.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Scanner: exiscan *1Dorbt-00047X-00*7luz.mITiQw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---working!---
ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Found device at ID 6, Attempting to use PS/2
ppa: Communication established with ID 6 using PS/2
scsi9 : Iomega VPI0 (ppa) interface
  Vendor: IOMEGA    Model: ZIP 100           Rev: D.13
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi9, channel 0, id 6, lun 0
Attached scsi generic sg0 at scsi9, channel 0, id 6, lun 0,  type 0

Grant, thanks for your help. I kicked the drive in a act of desperation
with my feet and know what - it works now. ;-) Looks like a insulate
contact. Maybe i´ll get my soldering iron hot tomorrow to fix this.

Best Regards
Sebastian


