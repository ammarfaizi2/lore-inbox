Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbRDPMvm>; Mon, 16 Apr 2001 08:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131457AbRDPMvd>; Mon, 16 Apr 2001 08:51:33 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:50437 "EHLO
	mail.compro.net") by vger.kernel.org with ESMTP id <S131459AbRDPMvW>;
	Mon, 16 Apr 2001 08:51:22 -0400
Message-ID: <3ADAEA9B.D70DC130@compro.net>
Date: Mon, 16 Apr 2001 08:50:35 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org, markh@compro.net
Subject: Re: amiga affs support broken in 2.4.x kernels??
In-Reply-To: <3AD59EB9.35F3A535@compro.net> <3AD9FEDD.2B636582@linux-m68k.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Hi,
> 
> Mark Hounschell wrote:
> 
> >  I'm not a list member so IF you respond to this mail please CC me.
> > I've been looking at the archives and see some problems with the 2.3.x
> > kernel versions and affs support.
> 
> I've put a new version at
> http://www.xs4all.nl/~zippel/affs.010414.tar.gz
> 
> bye, Roman

Thanks, I can now mount affs filesystems. However when I try to write
to it via "cp somefile /amiga/somefile" I get a segmentation fault. If
I then do a "df -h" it hangs the system very much like the mount command
did before I installed your tar-ball. Was write support expected from
it.
Are you the NEW maintainer of the affs stuff. I very much appreciate
your
response and if I can help in any way just let me know. I use affs quite
a bit here at work in conjunction with UAE and real amigas.

I also received a response from I guess the original
maintainer,           Hans-Joachim Widmaier <hjw@zvw.de>.
I quote:

"?affs is broken since somewhere in 2.3.xx. Alas, I do not have
the time
anymore to do anything about it, and my Amiga ran its last
program, too,
so I cannot test anymore. Last I know is that several guys
wanted to
look after affs in 2.4--at least make it run--, but it seems
that nothing
much has been done in that way. :-(

Sorry for not bearing better news."

unquote:

I was very much relieved to from you as I know have HOPE for a
completely working affs again.

Thanks

Mark Hounschell
markh@compro.net
--
