Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277653AbRLQLbG>; Mon, 17 Dec 2001 06:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285096AbRLQLa4>; Mon, 17 Dec 2001 06:30:56 -0500
Received: from [62.245.135.174] ([62.245.135.174]:14979 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S277653AbRLQLap>;
	Mon, 17 Dec 2001 06:30:45 -0500
Message-ID: <3C1DD75D.3BECBCF@TeraPort.de>
Date: Mon, 17 Dec 2001 12:30:37 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17-rc1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-rc1
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 12/17/2001 12:30:37 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 12/17/2001 12:30:44 PM,
	Serialize complete at 12/17/2001 12:30:44 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux 2.4.17-rc1
> 
> 
> Hi,
> 
> I've just copied 2.4.17-rc1 to ftp.kernel.org... Its mirroring yet,
> probably.
> 
> Well, I want people with the "unfreeable" buffer/cache problem to confirm
> with me that 2.4.17-rc1 is working ok.
> 
> The same change which should fix that problem also should make 2.4 a bit
> less "swap happy".
> 
Marcello,

 the system feels a bit better. This on a 320MB Toshiba notebook with
64MB swap. I have forced a complete run of "updatedb", while running
"vmware" and NetScape.

 Still swapping out, but the behaviour is [much] smoother. Not so many
"hangs" when the local disk is busy.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
