Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315250AbSDWPrK>; Tue, 23 Apr 2002 11:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315251AbSDWPrJ>; Tue, 23 Apr 2002 11:47:09 -0400
Received: from [62.245.135.174] ([62.245.135.174]:43689 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S315250AbSDWPrH>;
	Tue, 23 Apr 2002 11:47:07 -0400
Message-ID: <3CC581F5.2FBEA0C1@TeraPort.de>
Date: Tue, 23 Apr 2002 17:47:01 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: XFS in the main kernel
In-Reply-To: <3CC56355.E5086E46@TeraPort.de> <3CC56FE9.1080303@sgi.com>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/23/2002 05:47:01 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/23/2002 05:47:07 PM,
	Serialize complete at 04/23/2002 05:47:07 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord wrote:
> 
> Martin Knoblauch wrote:
> 
> >
> > definitely. Unless XFS is in the mainline kernel (marked as
> >experimantal if necessary) it will not get good exposure.
> >
> > The most important (only) reason I do not use it (and recommend our
> >customers against using it) is that at the moment it is impossible to
> >track both the kernel and XFS at the same time. This is a shame, because
> >I think that for some application XFS is superior to the other
> >alternatives (can be said about the other alternatives to :-).
> >
> 
> You would be surprised about the level of exposure XFS is getting, a lot
> more
> than you might realize. It is in everything from settop boxes and fiber
> channel
> switches to NAS boxes, those folks in general do not want to advertise.
> Here are
> a few larger scale installations out there:
> 
> http://oss.sgi.com/projects/xfs/xfs_users.html
> 
> Steve
Steve,

 no question that those are seriour users that give you serious
feedback. And if you call that
exposure, I am not going to argue. It is your project, it is your
marketing. (And *I* am not going to argue about SGI marketing :-(

 From a mainline point of view XFS on Linux will only be successfull if
it is "in the kernel". Fully maintained and "Linus approved". I am not
sure when SGI started the port (could even go back to the time when I
worked for them, late 1997). Definitely quite some time. By now it
should be in the kernel. Maybe marked "experimental". As I see it now
EXT3, ReiserFS and maybe JFS are just eating the XFS lunch away.

 In any case, the Vanderbilt comment is right on.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
