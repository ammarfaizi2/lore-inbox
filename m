Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264142AbRFLBlC>; Mon, 11 Jun 2001 21:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264143AbRFLBkx>; Mon, 11 Jun 2001 21:40:53 -0400
Received: from altus.drgw.net ([209.234.73.40]:42252 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S264142AbRFLBkm>;
	Mon, 11 Jun 2001 21:40:42 -0400
Date: Mon, 11 Jun 2001 20:39:43 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Mark Salisbury <mbs@mc.com>
Cc: Zehetbauer Thomas <TZ@link.topcall.co.at>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: IBM PPC 405 series little endian?
Message-ID: <20010611203943.S753@altus.drgw.net>
In-Reply-To: <41EA756DBC9FD0118CFC0020AFDB5C5A188DE7@tcint1ntsrv> <20010611133949.Q753@altus.drgw.net> <01061115111305.01190@pc-eng24.mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01061115111305.01190@pc-eng24.mc.com>; from mbs@mc.com on Mon, Jun 11, 2001 at 03:08:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2001 at 03:08:26PM -0400, Mark Salisbury wrote:
> On Mon, 11 Jun 2001, Troy Benjegerdes wrote:
> > On Mon, Jun 11, 2001 at 01:34:21PM +0200, Zehetbauer Thomas wrote:
> > > Has someone experimented with running linux in little-endian mode on IBM
> > > PowerPC 405 (Walnut) yet?
> > 
> > With the possible exception of the matrox guy, I haven't heard of ANYONE 
> > running in LE mode on ppc. The second problem is going to be to recompile 
> > ALL the applications you want and hope they work.
> 
> actually, we run ppc 603, 750 and 74xx series ppc's little endian in a PCI
> based shared memory multicomputer.

What I should have said was 'anyone running Linux in LE mode on ppc'.

But that's also very interesting that you're running mcos in LE mode. I'm 
really curious as to why.. because PCI is little endian maybe?

Thanks.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Shulz
