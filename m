Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSEBHfq>; Thu, 2 May 2002 03:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSEBHfp>; Thu, 2 May 2002 03:35:45 -0400
Received: from [62.245.135.174] ([62.245.135.174]:9643 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S314277AbSEBHfp>;
	Thu, 2 May 2002 03:35:45 -0400
Message-ID: <3CD0EC48.A0F13F53@TeraPort.de>
Date: Thu, 02 May 2002 09:35:36 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: kaos@ocs.com.au
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: The tainted message
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 05/02/2002 09:35:37 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 05/02/2002 09:35:45 AM,
	Serialize complete at 05/02/2002 09:35:45 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: The tainted message
> 
> From: Keith Owens (kaos@ocs.com.au)
> Date: Tue Apr 30 2002 - 08:44:48 EST
> 
> 
> On Tue, 30 Apr 2002 23:37:32 +1000,
> john slee <indigoid@higherplane.net> wrote:
> >how about adding an optional tag to modules for a support/faq URL?
> 
> It is already there!
> 
> MODULE_LICENSE("Proprietary FOO P/L - contact someone@somewhere for support");
> 
> insmod prints the license text.
> 

 purely technical question: does this work with the "compatible" license
strings without making them incompatible? E.g. would this be a
compatible license:

MODULE_LICENSE("GPL - contact someone@somewhere for support");

 Just that something is GPL doesn't mean I should contact LKML for
support at all :-)

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
