Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131986AbRDJTvc>; Tue, 10 Apr 2001 15:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131988AbRDJTvV>; Tue, 10 Apr 2001 15:51:21 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:28066 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S131986AbRDJTut>; Tue, 10 Apr 2001 15:50:49 -0400
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Re: No 100 HZ timer !
Message-ID: <3AD36409.6A956F3A@i.am>
Date: Tue, 10 Apr 2001 19:50:33 GMT
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010410202416.A21512@pcep-jamie.cern.ch>
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-RTL3.0 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> Alan Cox wrote:
 > 
> Except for cards which don't generate an irq on vsync but do let you see
> how the raster is proceeding.  (I vaguely recall these).  For which a
> PLL and, wait for it.... high resolution timer is needed.
> 
> Perhaps that's a 1990s problem that doesn't need a 2000s solution though :-)

I think it would be wrong if we could not add new very usable features
to the system just because some old hardware doesn't support it.
(I also believe this was the original idea why XFree has no user
interface
for such important thing like VBI screen switch - because not all device
could provide such information)
I think those who use such old system probably don't need any
synchronized
video or game output - simply because it will not work in such system
anyway :)
so we should not worry about this.

kabi@i.am

