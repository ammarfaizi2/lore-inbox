Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131891AbRA3THT>; Tue, 30 Jan 2001 14:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132219AbRA3THJ>; Tue, 30 Jan 2001 14:07:09 -0500
Received: from [64.16.10.150] ([64.16.10.150]:54790 "EHLO cougar.intrinsyc.com")
	by vger.kernel.org with ESMTP id <S131891AbRA3THH>;
	Tue, 30 Jan 2001 14:07:07 -0500
Message-ID: <3A774A2A.6294B6D4@intrinsyc.com>
Date: Tue, 30 Jan 2001 18:11:38 -0500
From: Daniel Chemko <dchemko@intrinsyc.com>
Reply-To: dchemko@intrinsyc.com
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael B. Trausch" <fd0man@crosswinds.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Off-Topic?]  Mixer device and controls (/dev/mixer)
In-Reply-To: <Pine.LNX.4.21.0101300442420.30532-100000@fd0man.accesstoledo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not really looked into this but I think this option is only supported
when the audio hardware supports bass and treble.

"Michael B. Trausch" wrote:

> I have one small question about the Linux mixer device.  I realize that
> the drivers (such as OSS and ALSA) have their own standards for the mixer
> and dsp devices and such, and so I'm not really sure if this is on topic
> or not.  If you're still interested in my question, tho, read on ;p.
>
> I've noticed that with some audio devices, I have a Bass and Treble
> setting that I can play with (and usually do, becuase it makes things
> sound MUCH better).  Why don't I have that in some devices, and is there
> a way (through the kernel, or through a userspace program) to make up the
> difference?  I use mpg123 to play my mp3 files, but that will change soon
> as I am building myself a new installation of Linux (from the kernel on up
> ;p... the Distributions aren't keeping up as much as I want and I want all
> my own home-built software anyway, except for X, 'cuz that's a bitch to
> attempt to compile on my own).
>
> Anyway, does anybody know the answer to that one?
>
>         Thanks!
>         Mike
>
> ===========================================================================
> Michael B. Trausch                                    fd0man@crosswinds.net
> Avid Linux User since April, '96!                           AIM:  ML100Smkr
>
>               Contactable via IRC (DALNet) or AIM as ML100Smkr
> ===========================================================================
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
