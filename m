Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277213AbRJDUiu>; Thu, 4 Oct 2001 16:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277212AbRJDUik>; Thu, 4 Oct 2001 16:38:40 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:3221 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S277220AbRJDUi2>; Thu, 4 Oct 2001 16:38:28 -0400
Date: 04 Oct 2001 21:50:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8ADlROk1w-B@khms.westfalen.de>
In-Reply-To: <20011004034600.B29438@codepoet.org>
Subject: Re: Security question: "Text file busy" overwriting executables but no
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20011004113019.L22640@niksula.cs.hut.fi> <Pine.GSO.4.21.0110040004430.26177-100000@weyl.math.psu.edu> <m14rpg0w4a.fsf@frodo.biederman.org> <20011004113019.L22640@niksula.cs.hut.fi> <20011004034600.B29438@codepoet.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andersen@codepoet.org (Erik Andersen)  wrote on 04.10.01 in <20011004034600.B29438@codepoet.org>:

> On Thu Oct 04, 2001 at 11:30:19AM +0300, Ville Herva wrote:
> > On Thu, Oct 04, 2001 at 12:15:01AM -0600, you [Eric W. Biederman] claimed:
> > >
> > > <snip size of glibc>
> >
> > Where size is an issue, diet libc might be an alternative:
> >
> > http://www.fefe.de/dietlibc/
> >
> > (287kB statically linked zsh is not too shabby, I reckon.)
>
> uClibc is also a nice alternative.  Works just great and uses glibc
> header files.  I only fully support shared libs on x86 and arm
> at the moment.
>
> http://cvs.uclinux.org/uClibc.html
>
> (I need to update the webpage sometime)
>
> > That and things like busybox:
> >
> > http://busybox.lineo.com/
>
> Why thanks.  I've sure worked hard to make it be nice and small...

And some people *still* start threads titled "Busybox still too bloated".

(Screaming their heads off for a reduction of around 50 KB, IIRC.)

MfG Kai
