Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132746AbRC2PRC>; Thu, 29 Mar 2001 10:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132743AbRC2PQw>; Thu, 29 Mar 2001 10:16:52 -0500
Received: from [194.25.18.216] ([194.25.18.216]:6665 "EHLO ntovmsw02.otto.de")
	by vger.kernel.org with ESMTP id <S132746AbRC2PQg>;
	Thu, 29 Mar 2001 10:16:36 -0500
Message-Id: <4B6025B1ABF9D211B5860008C75D57CC0271B9DE@NTOVMAIL04>
From: "Butter, Frank" <Frank.Butter@otto.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 2.4 on COMPQ Proliant
Date: Thu, 29 Mar 2001 17:11:16 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone experiences with 2.4.x on recent Compaq Proliant Servers (e.g.
ML570)?

I've installed RedHat7 and it worked fine out of the box.
Except that the SMP-enabled kernel stated there was no SMP-board detected
;-/
For some reasons (Fibrechannel drivers and so on) I've compiled
2.4.2 and installed it. Although I've compiled the support in, the
NCR-SCSI-chip was not found and therefore no root-partition. It is a model
supported by 53c8xx - detected by the original RedHat-kernel.  

For testing I compiled a kernel with all (!) scsi-low-level-drivers -
with the same result. The SMP-board also was NOT detected by 2.4.2.

Any hint?

Frank
