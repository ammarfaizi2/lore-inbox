Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSDWPzn>; Tue, 23 Apr 2002 11:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315248AbSDWPzm>; Tue, 23 Apr 2002 11:55:42 -0400
Received: from [62.245.135.174] ([62.245.135.174]:44969 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S315245AbSDWPzl> convert rfc822-to-8bit;
	Tue, 23 Apr 2002 11:55:41 -0400
Message-ID: <3CC583F8.8A88360A@TeraPort.de>
Date: Tue, 23 Apr 2002 17:55:36 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
CC: kernel@Expansa.sns.it,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: XFS in the main kernel
In-Reply-To: <3CC56355.E5086E46@TeraPort.de> <3CC581F6.6050103@loewe-komp.de>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/23/2002 05:55:35 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/23/2002 05:55:41 PM,
	Serialize complete at 04/23/2002 05:55:41 PM
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler wrote:
> 
> Martin Knoblauch wrote:
> >>Re: XFS in the main kernel
> >>
> >
> >  so, what were the main obstacles again? The VFS layer?
> >
> 
> The VFS and such features like "delayed block allocation". XFS tries
> to gather 64K or so before submitting to disk/block layer.
> 
> FWIW, SuSE 8 ships with full (but experimental marked) XFS support.

 Definitely a step forward. But some people (including myself, I guess)
do not like distribution kernels. Yeah, hard to please - I know :-). I
use SuSE on the desktop, but not because of the kernel. I use RedHat on
servers and compute nodes, but not because of the kernel.

Martin
PS: Thanks for the hint. I didn't realize it when I upgraded to 8.0.
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
