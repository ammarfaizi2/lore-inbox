Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSEBNIN>; Thu, 2 May 2002 09:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSEBNIM>; Thu, 2 May 2002 09:08:12 -0400
Received: from [62.245.135.174] ([62.245.135.174]:18859 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S314396AbSEBNIL>;
	Thu, 2 May 2002 09:08:11 -0400
Message-ID: <3CD13A35.1036639@TeraPort.de>
Date: Thu, 02 May 2002 15:08:05 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: The tainted message
In-Reply-To: <28821.1020340504@ocs3.intra.ocs.com.au>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 05/02/2002 03:08:05 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 05/02/2002 03:08:11 PM,
	Serialize complete at 05/02/2002 03:08:11 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Thu, 02 May 2002 09:35:36 +0200,
> Martin Knoblauch <Martin.Knoblauch@TeraPort.de> wrote:
> > purely technical question: does this work with the "compatible" license
> >strings without making them incompatible? E.g. would this be a
> >compatible license:
> >
> >MODULE_LICENSE("GPL - contact someone@somewhere for support");
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=99926682329331&w=2

 OK, if I read this correctly, the suggestion of a MODULE_SUPPORT tag
makes a lot of sense. Although, one could (mis)use the MODULE_AUTHOR for
it.

 Given the sloppyness/lazyness of people/programmes in general, use of
MODULE_LICENSE, MODULE_AUTHOR and MODULE_DESCRIPTION should be enforced
at compile time.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
