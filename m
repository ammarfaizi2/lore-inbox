Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292289AbSB0KTR>; Wed, 27 Feb 2002 05:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292315AbSB0KTI>; Wed, 27 Feb 2002 05:19:08 -0500
Received: from [62.245.135.174] ([62.245.135.174]:6279 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S292289AbSB0KS5>;
	Wed, 27 Feb 2002 05:18:57 -0500
Message-ID: <3C7CB28A.CAD095B5@TeraPort.de>
Date: Wed, 27 Feb 2002 11:18:50 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-ac1-K3-preempt-lockbr-stats-stuff-lowlat i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Martin.Bligh@us.ibm.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in thetree
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 02/27/2002 11:18:49 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 02/27/2002 11:18:56 AM,
	Serialize complete at 02/27/2002 11:18:56 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
> 
> From: Martin J. Bligh (Martin.Bligh@us.ibm.com)
> Date: Mon Feb 25 2002 - 20:32:06 EST
> 
> > Not to begin the flamewar, but no thanks. rmap-12f blows -aa away AFAIK
> > on this P200 w/ 64MB ram.
> 
> rmap still sucks on large systems though. I'd love to see rmap
> in the main kernel, but it needs to get the scalability fixed first.
> The main problem seems to be pagemap_lru_lock ... Rik & crew
> know about this problem, but let's give them some time to fix it
> before rmap gets put into mainline ....
> 
> Martin.
> 
Martin,

 just out of curiosity: where does "large systems" start in your
context?

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
