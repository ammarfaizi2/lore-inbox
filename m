Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135841AbRDYLQJ>; Wed, 25 Apr 2001 07:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135842AbRDYLQA>; Wed, 25 Apr 2001 07:16:00 -0400
Received: from ameise.opto.de ([62.154.242.130]:8425 "HELO ameise.opto.de")
	by vger.kernel.org with SMTP id <S135841AbRDYLPm>;
	Wed, 25 Apr 2001 07:15:42 -0400
Date: Wed, 25 Apr 2001 13:15:40 +0200 (CEST)
From: Christoph Biardzki <cbi@cebis.net>
To: linux-kernel@vger.kernel.org
Subject: SCSI-Multipath driver for 2.4?
Message-ID: <Pine.LNX.4.21.0104251311420.25506-100000@ameise.opto.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I wondered whether thera are already effrots to por the Multipath-driver
for FibreChannel (http://t3.linuxcare.org) to the 2.4 kernel? This patch
allows a transparent failover to another path to FC-attached
disk in case the primary path fails.


Is there any documentation about the changes in the SCSI-driver interfaces
from 2.2 -> 2.4 (eg. in sd.c) ?


Christoph

