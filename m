Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270969AbRHXIaQ>; Fri, 24 Aug 2001 04:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270973AbRHXIaH>; Fri, 24 Aug 2001 04:30:07 -0400
Received: from mail.teraport.de ([195.143.8.72]:54917 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S270969AbRHXI35>;
	Fri, 24 Aug 2001 04:29:57 -0400
Message-ID: <3B861089.B3640617@TeraPort.de>
Date: Fri, 24 Aug 2001 10:30:01 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: laughing@shared-source.org
Subject: Re: Linux 2.4.8-ac10
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/24/2001 10:30:06 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/24/2001 10:30:13 AM,
	Serialize complete at 08/24/2001 10:30:13 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux 2.4.8-ac10
> 
> From: Alan Cox (laughing@shared-source.org)
> o Put config hooks in to make qlogicfc firmware (me)
>         optionally loadable for weird hardware
>         | Needs a suitable firmware file adding ..

 shouldn't the question about the FW only be asked if the FC driver is
actually requested? I have not requested the driver, but get asked (make
oldconfig) about the FW.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
