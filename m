Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290232AbSBNGk7>; Thu, 14 Feb 2002 01:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290423AbSBNGkt>; Thu, 14 Feb 2002 01:40:49 -0500
Received: from smtp.alacritech.com ([209.10.208.82]:10633 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S290232AbSBNGkd>; Thu, 14 Feb 2002 01:40:33 -0500
Message-ID: <3C6B5A2E.2C2637C7@alacritech.com>
Date: Wed, 13 Feb 2002 22:33:18 -0800
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Hiro Yoshioka <hyoshiok@miraclelinux.com>,
        lkcd-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [lkcd-general] Re: status of LKCD into Linux Kernel
In-Reply-To: <20020214114457A.hyoshiok@miraclelinux.com> <3C6B51AA.6EB614C3@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of progress has been made ...

LKCD is currently up to 2.4.17, and should be simple to
move into 2.5.

I've asked Linus and others for inclusion in the past, and I
think it deserves consideration for 2.5, especially now that it
can be built into the kernel without having to be turned on.
At least in those cases, people who want it can turn it on,
and those that don't will never see it.

The LKCD development team (over 10 engineers now) is ready.

--Matt

Jeff Garzik wrote:
> 
> Hiro Yoshioka wrote:
> > I have a naive question. Will the LKCD be merged into
> > the Linus' kernel? If yes, when? wild guess?
> 
> I talked with Matt Robinson(sp?) at LinuxWorld-NY about LKCD for a few
> minutes...  he gave me the impression that a lot of progress has been
> made recently.  IBM apparently has some guys working on it, too.
> 
> I've always thought Linux needs industrial strength crash dumps like the
> other Unices.  There are many benefits, but my own is self interest:
> bug reports get 1000 times better, since you get along with the crash
> point a lot more info about the state of the system at the time of the
> crash.
> 
> So, I hope LKCD is looked upon favorably by the Penguin Gods. :)
> 
>         Jeff
