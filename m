Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbQKQRdc>; Fri, 17 Nov 2000 12:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129688AbQKQRdM>; Fri, 17 Nov 2000 12:33:12 -0500
Received: from s8n223.hfx.eastlink.ca ([24.222.8.223]:25357 "HELO
	ghost.nslug.ns.ca") by vger.kernel.org with SMTP id <S129652AbQKQRdC>;
	Fri, 17 Nov 2000 12:33:02 -0500
Date: Fri, 17 Nov 2000 13:14:22 -0400
To: linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
Subject: Re: [ANNOUNCE] ide-patch for 2.2.18(pre)
Message-ID: <20001117131421.C17826@ghost.nslug.ns.ca>
In-Reply-To: <Pine.LNX.4.21.0010280032200.9401-100000@tricky> <Pine.NEB.4.30.0010290207120.19188-100000@gaia.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.NEB.4.30.0010290207120.19188-100000@gaia.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Sun, Oct 29, 2000 at 02:12:32AM +0200
From: fifield@ghost.nslug.ns.ca (Jamie Fifield)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2000 at 02:12:32AM +0200, Adrian Bunk wrote:
> On Sat, 28 Oct 2000, Bartlomiej Zolnierkiewicz wrote:
> 
> >...
> > I don't use 2.2.x kernels anymore so I don't do ide-patches for pre
> > kernels. But there will be patches for stable 2.2.x. (Although it's
> > a real pain - I hate doing backporting instead of new stuff).
> 
> I have modified your patch to apply cleanly against 2.2.18pre18. You can
> find this patch at
> 
>   http://www.fs.tum.de/~bunk/ide.2.2.18pre18.adrian.patch.bz2
 
And I in turn have done the same for 2.2.18pre21

http://www.chebucto.ns.ca/~fifield/patches/ide.2.2.18pre21.jamie.patch.bz2

Compiled and used it on a couple different chipsets.  Seems to work for me.

-- 
Jamie Fifield
<fifield@chebucto.ns.ca>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
