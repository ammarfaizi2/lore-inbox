Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272828AbRIRQu1>; Tue, 18 Sep 2001 12:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272982AbRIRQuR>; Tue, 18 Sep 2001 12:50:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:47747 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272828AbRIRQuG>; Tue, 18 Sep 2001 12:50:06 -0400
Date: Tue, 18 Sep 2001 12:49:25 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bruce Blinn <blinn@MissionCriticalLinux.com>
cc: Masoud Sharbiani <masu@cr213096-a.rchrd1.on.wave.home.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Reading Windows CD on Linux 2.4.6
In-Reply-To: <3BA76AA7.3371FE54@MissionCriticalLinux.com>
Message-ID: <Pine.LNX.3.95.1010918124738.22153A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, Bruce Blinn wrote:

> "Richard B. Johnson" wrote:
> > 
> > Okay. That's good. The guy that asked to get the image to find out what
> > was happening can probably use a small piece of that to find out what
> > is going on. It probably is a CD data + Music image where the first
> > readable stuff is data, followed by a music image.
> > 
> > You can try cdda2wav -D0,4,0, -B. You will probably get some *.wav files.
> > 
> 
> I cannot find the cdda2wav command on my system.  Also, my disks only
> have data on them, not music.
> 
> Thanks,
> Bruce
> -- 

The point is that these M$ disks just might be multi-session which
explains a lot. If so, the music-extraction software cited just
might show it without having to look further.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


