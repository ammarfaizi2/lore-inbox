Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292233AbSBYUi0>; Mon, 25 Feb 2002 15:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292222AbSBYUiH>; Mon, 25 Feb 2002 15:38:07 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.34]:56719 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S291400AbSBYUh5>; Mon, 25 Feb 2002 15:37:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <DevilKin-LKML@blindguardian.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.18
Date: Mon, 25 Feb 2002 21:37:42 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0202251613300.31438-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0202251613300.31438-100000@freak.distro.conectiva>
X-Cats: All your linux' belong to us!
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020225203750.C531B218392@tartarus.telenet-ops.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 February 2002 20:18, Marcelo Tosatti wrote:
> On Mon, 25 Feb 2002, Holzrichter, Bruce wrote:
> > > Ok, DAMN. I missed the -rc4 patch in 2.4.18. Real sorry about that.
> > >
> > > 2.4.19-pre1 will contain it.
> >
> > Should 2.4.18 final get a -dontuse tag or something?
>
> No. A "-dontuse" tag should be only used when the kernel can cause damage
> in some way.
>
> The patch which I missed only breaks static apps on _some_ architectures
> (not including x86).
>
> > Some people may get confused grabbing 2.4.18 and not getting the fixes
> > that went into rc-4? Just a thought...
>
> I already changed ftp.kernel.org's changelog adding:
>
> "Update: The SET_PERSONALITY fix in rc4 has _not_
> been included in the final 2.4.18 by mistake."
>
> I guess thats enough.

Wouldn't it be easier just to make a new 2.4.18 with the patch applied?

Just to make all our lives a bit easier...

DK
