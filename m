Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313012AbSEHK70>; Wed, 8 May 2002 06:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313016AbSEHK7Z>; Wed, 8 May 2002 06:59:25 -0400
Received: from [62.245.135.174] ([62.245.135.174]:51372 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S313012AbSEHK7Y> convert rfc822-to-8bit;
	Wed, 8 May 2002 06:59:24 -0400
From: "Martin.Knoblauch" <Martin.Knoblauch@teraport.de>
Reply-To: Martin.Knoblauch@teraport.de
Organization: TeraPort GmbH
To: rml@tech9.net
Subject: Re: [PATCH] preemptive kernel for 2.4.19-pre7-ac4
Date: Wed, 8 May 2002 12:59:17 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200205081259.17948.Martin.Knoblauch@teraport.de>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 05/08/2002 12:59:17 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 05/08/2002 12:59:24 PM,
	Serialize complete at 05/08/2002 12:59:24 PM
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain;
  charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The preempt-kernel patch for 2.4.19-pre7-ac4 is now available at 

 What about lock-break for the -ac series? Or does this conflict with rmap 
and/or O(1)?

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759

