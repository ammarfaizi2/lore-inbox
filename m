Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261226AbRELLee>; Sat, 12 May 2001 07:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261227AbRELLeX>; Sat, 12 May 2001 07:34:23 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:11782 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261226AbRELLeL>; Sat, 12 May 2001 07:34:11 -0400
Date: 12 May 2001 13:00:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <80knzI9mw-B@khms.westfalen.de>
In-Reply-To: =?ISO-8859-1?Q?<p0510030db7221c090810@[10.128.7.49]=FE2>?=
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
=?ISO-8859-1?Q?References: _<20010511133242.B3224@bacchus.dhis.org>_<p0510030ab716bdcf5556@[207.213.214.37]>_<20010511133242.B3224@bacchus.dhis.org>_<p0510030db7221c090810@[10.128.7.49]>_<p0510030db7221c090810@[10.128.7.49]=B72>?=
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlundell@pobox.com (Jonathan Lundell)  wrote on 11.05.01 in <p0510030db7221c090810@[10.128.7.49]·2>:

> At 1:32 PM -0300 2001-05-11, Ralf Baechle wrote:
> >On Thu, May 03, 2001 at 12:51:25AM -0700, Jonathan Lundell wrote:
> >>  Kai Henningsen wrote:
> >>  >What's a lot more important is that the mail standards say that this
> >>  >stuff should not be interpreted by the receivers as needing wrapping,
> >>  >so irregardless of good or bad design it's just plain illegal.
> >>  >
> >>  >If you want to support wrapping with plain text, investigate
> >>  >format=flowed.
> >>
> >>  Yes, I did that.
> >>
> >  > I'm curious, though: I haven't found the mail standards that forbid
> >>  receivers to wrap long lines. Certainly many mail clients do it.
> >>  What's the relevant RFC?
> >
> >RFC 2822, 2.1.1.
>
> Thanks. It's not quite a standard yet, but it's true, it does limit
> lines to 998 characters. Sort of a strange limit, but there you
> are....

It's the unchanged old RFC 821 SMTP line length limit [4.5.3 SIZES, text  
line] (the consequences are just spelt out more clearly). And 821 is from  
1982, so this is certainly not new in any sense of the word.

MfG Kai
