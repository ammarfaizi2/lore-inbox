Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315227AbSEFWzC>; Mon, 6 May 2002 18:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315255AbSEFWzB>; Mon, 6 May 2002 18:55:01 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:51720 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S315227AbSEFWzA>; Mon, 6 May 2002 18:55:00 -0400
Date: Tue, 7 May 2002 00:54:31 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Erik Andersen <andersen@codepoet.org>
cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [ANN] NTFS 2.0.6a for Linux 2.4.18
In-Reply-To: <20020506224318.GA27527@codepoet.org>
Message-ID: <Pine.LNX.4.33.0205070052560.6482-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002, Erik Andersen wrote:

> On Tue May 07, 2002 at 12:27:17AM +0200, Pawel Kot wrote:
> > Hi all,
> >
> > With much help from Anton, I backported the NTFS-TNG driver to 2.4.x Linux
> > kernel series. If you are afraid of running 2.5.x kernel, but you would
> > like to get all benefits of the new NTFS driver use this one.
> >
> > It should have all features the driver for 2.5.x has -- only 2.5.x series
> > specific code was removed/altered.
> >
> > The driver itself really looks to be stable, it survived all the run
> > tests, but if you have any problems running it, please, contact me or
> > Anton.
>
> Excellent work.

Thanks :-)

> As I recall, the 2.5.x version is read-only.  Does
> this version have write support, or is it read only with this patch?

Nope. This is also read-only support. According to Anton, it will take a
lot of time to have write support for NTFS...

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

