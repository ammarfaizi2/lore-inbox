Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277322AbRJOIBj>; Mon, 15 Oct 2001 04:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277331AbRJOIB3>; Mon, 15 Oct 2001 04:01:29 -0400
Received: from mail.teraport.de ([195.143.8.72]:22144 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S277322AbRJOIBT>;
	Mon, 15 Oct 2001 04:01:19 -0400
Message-ID: <3BCA97E9.7FC35C0D@TeraPort.de>
Date: Mon, 15 Oct 2001 10:01:45 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: eth0: card reports no resources. [2.4.9-ac18, eepro100 as module]
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 10/15/2001 10:01:45 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 10/15/2001 10:01:51 AM,
	Serialize complete at 10/15/2001 10:01:51 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 one dual P-III server that I support gives me a bunch of

eth0: card reports no resources.

 in dmesg output. Seems to be load dependent, but I am not sure. Two
questions:

- are there workarounds for this? Lame, I know :-(
- what should I look for in order to track this down?

Thanks
Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
