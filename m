Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbRETESk>; Sun, 20 May 2001 00:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbRETESa>; Sun, 20 May 2001 00:18:30 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:57106 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S261409AbRETESO>; Sun, 20 May 2001 00:18:14 -0400
To: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: abuse@madhouse.demon.co.uk (Andrew Bray)
Subject: Problems with buslogic and osst driver
Date: 20 May 2001 04:03:27 GMT
Organization: Private Internet Node
Message-ID: <slrn9geggf.soc.abuse@madhouse.demon.co.uk>
Reply-To: Andrew Bray <andy@chaos.org.uk>
X-Trace: madhouse.demon.co.uk 990331407 31712 127.0.0.1 (20 May 2001 04:03:27 GMT)
X-Complaints-To: news@madhouse.demon.co.uk
NNTP-Posting-Date: 20 May 2001 04:03:27 GMT
User-Agent: slrn/0.9.6.2 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I (and others on the OnStream osst driver mailing) list cannot get this tape 
drive to work with BusLogic SCSI host adapters.

This is with 2.2.19 and 2.4.3 and either a MultiMaster or FlashPoint card.

I have been in contact with Willem Reide (the author of the osst driver) and
he has identified some spurious errors surfacing from the BusLogic driver.

Willem has suggested some workarounds for the osst driver that ignore these
errors, but they are not sufficient to get the tape going.

So I thought that it was time to bring in Leonard Zubkoff, who is still listed
as the maintainer for the Buslogic driver.

I haven't exchanged E-Mail with Leonard since 1995, but I sent off some mail
anyway.  I have as yet had no reply from him.

So I have 2 questions:

1) Does anyone know if Leonard Zubkoff is still around?

2) Is anyone else looking after the BusLogic driver these days?

Regards,

Andy

-- 
-----------------------------------------------------------------------------
Andrew Bray, PWMS, MA,              |  preferred:    mailto:andy@chaos.org.uk
London, England                     |  or:   mailto:andy@madhouse.demon.co.uk
PGP id/fingerprint:  D811F5C9/26 B5 42 C6 F4 00 B2 71 BA EA 9B 81 6C 65 59 07

