Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUFAFRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUFAFRt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 01:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbUFAFRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 01:17:49 -0400
Received: from miranda.se.axis.com ([193.13.178.2]:52946 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264770AbUFAFRr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 01:17:47 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Sam Ravnborg'" <sam@ravnborg.org>,
       "=?iso-8859-1?B?Qmr2cm4gV2Vz6W4=?=" <bjorn.wesen@axis.com>
Cc: "'Dan Kegel'" <dank@kegel.com>,
       "'Mikael Starvik'" <mikael.starvik@axis.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Delete cris architecture?
Date: Tue, 1 Jun 2004 07:17:33 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F48E@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668CD62C1@exmail1.se.axis.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The CRIS architecture is very much alive and locally we are running 2.6.6.
It is true that I haven't submitted any patches since 2.5.74 or 
something like that. It is my intention to send in a patch asap,
hopefully this week.

I will submit 2.6 patches more often in the future. Later this year 
we will also add support for a new CRIS subarchitecture.

/Mikael (CRIS maintainer)

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Sam Ravnborg
Sent: Monday, May 31, 2004 8:42 PM
To: Björn Wesén
Cc: Dan Kegel; Mikael Starvik; linux-kernel@vger.kernel.org
Subject: Re: Delete cris architecture?


On Mon, May 31, 2004 at 06:14:02PM +0200, Bjorn Wesen wrote:
> The CRIS architecture is stable and supported by Axis Communications 
> officially in 2.4, but the 2.6 port is work-in-progress, thus you could 
> expect problems building it from the vanilla kernel source. It works 
> in-house on 2.6, but perhaps all patches have not trickled out to the 
> official kernel yet (although they should have I think, so it's good that 
> you mention stuff like this).

When grepping the source and even doing cross architecture changes it is
nice to have a ratehr up-to-date version in the main stream kernel.

It would be nice if Axis could at least drop an update of the tree for
each kernel release (provided there are any changes).
This would allow all of us to get a better overview, and in some cases
we may even introduce new stuff / fix errors.

So please start to feed Andrew (or Linus) regularly with updates.

	Sam
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

