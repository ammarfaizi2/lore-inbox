Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSDXHOF>; Wed, 24 Apr 2002 03:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311273AbSDXHOE>; Wed, 24 Apr 2002 03:14:04 -0400
Received: from [62.245.135.174] ([62.245.135.174]:53161 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S311180AbSDXHOE>;
	Wed, 24 Apr 2002 03:14:04 -0400
Message-ID: <3CC65B35.686100AF@TeraPort.de>
Date: Wed, 24 Apr 2002 09:13:57 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: XFS in the main kernel
In-Reply-To: <Pine.LNX.4.44.0204232330430.4925-100000@Expansa.sns.it>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/24/2002 09:13:57 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/24/2002 09:14:04 AM,
	Serialize complete at 04/24/2002 09:14:04 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:
> 
> On Tue, 23 Apr 2002, Martin Knoblauch wrote:
> 
> > > Re: XFS in the main kernel
> > >
> >  definitely. Unless XFS is in the mainline kernel (marked as
> > experimantal if necessary) it will not get good exposure.
> 
> XFS needs 2.5, not 2.4, because of a lot of reasons.
> If I do remember well a strong obiection to XFS is that it introduces a
> kernel thread to emulate Irix behavious to talk with pagebuf (a la Irix),
> end to have an interface with VM and Block Device layer.
> 
> This forces some vincles.
> 

 No problem with XFS going into 2.5 mainline, but not 2.4. But - is that
happening?

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
