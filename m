Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265119AbRFUTEm>; Thu, 21 Jun 2001 15:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265117AbRFUTEa>; Thu, 21 Jun 2001 15:04:30 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:62221 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S265116AbRFUTET>; Thu, 21 Jun 2001 15:04:19 -0400
Date: 21 Jun 2001 21:14:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <83JvUAC1w-B@khms.westfalen.de>
In-Reply-To: <3B32280A.ADC08780@efore.fi>
Subject: Re: temperature standard - global config option?
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <OFE74ECCAE.A9CB9437-ON80256A72.0045BC45@portsmouth.uk.ibm.com> <3B32280A.ADC08780@efore.fi>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lauri.tischler@efore.fi (Lauri Tischler)  wrote on 21.06.01 in <3B32280A.ADC08780@efore.fi>:

> Richard J Moore wrote:
> >
> > > 59.42886726469 ±2°C is obviously ludicrous, even if that's
> > > what my calculator gives me.  I should instead write 59 ±2°C, since
> >
> > So, if I follow you argument then shouldn't you be writing 58 ±2°C or
> > should it be 60 ±2°C ?
>
> What it means is that whatever dingus measured the temperature, reported
> the temperature as 59C.

Well, maybe. And maybe it reported the temperature as "76 units", where a  
unit is approximately 0.69°C, and zero units are approximately 6.99°C, and  
we happen to know the accuracy is 3 units.

(That makes out to 59.43 ±2.07°C, or 57.36 to 61.50°C, whereas 59 ±2°C  
works out to 57.00 to 61.00°C - they do overlap, but they're not the same.  
Now you might not care - but then again, you might care.)

MfG Kai
