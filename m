Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281267AbRKUDMx>; Tue, 20 Nov 2001 22:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281441AbRKUDMm>; Tue, 20 Nov 2001 22:12:42 -0500
Received: from mail008.mail.bellsouth.net ([205.152.58.28]:49305 "EHLO
	imf08bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281267AbRKUDMW>; Tue, 20 Nov 2001 22:12:22 -0500
Subject: Re: radeonfb bug: text ends up scrolling in the middle of tux.
From: Louis Garcia <louisg00@bellsouth.net>
To: Ingo.Saitz@stud.uni-hannover.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 20 Nov 2001 22:13:33 -0500
Message-Id: <1006312414.18119.8.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't seem to find that patch. This bug is annoying, can you please
tell me where I can get it?

Thanks, Louis


> On Mon, Nov 19, 2001 at 08:33:29PM -0500, Dan Merillat wrote:
> > Ok, I've poked around but I can't find a penguin or tux bitmap to
> > figure out why scrolling is so broken. I've got to login blind and 
type
> > reset to get the console back. Needless to say, no kernel messages
> > are readable after the mode-switch (they all overwrite themselves on
> > a single line)
>
> Yes, I encontered the same. See my previous message for a patch:
>
> Message-ID: <20011118163244.A1100@pinguin.subspace.exe>
> Subject: Debugging (?) output in 2.4.14 breaks radeon framebuffer
>
> The offending code seems to have entered the kernel at 2.4.14,
> 2.4.13 was OK on my box.
>
>   Ingo





