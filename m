Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131517AbQLHBkz>; Thu, 7 Dec 2000 20:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131499AbQLHBkp>; Thu, 7 Dec 2000 20:40:45 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:3076 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130695AbQLHBki>; Thu, 7 Dec 2000 20:40:38 -0500
Message-ID: <3A3033DD.FA33D0F9@timpanogas.org>
Date: Thu, 07 Dec 2000 18:05:33 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Rainer Mager <rmager@vgkk.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have previously reported this error (about three months ago) on 2.4
with XFree 3.3.6.  If you are running RedHat 6.2, then you are running
this X Server.  It also shows up on Calders'a 2.4 eDesktop.  It appears
to be something with glib 2.1 < versions on 2.4.  I also see it with
secure shell 1.2.27 on 2.4.  I've also seen it on RH 7.0 on 2.4 kernels
as well, but only with SSH.

Jeff

Rainer Mager wrote:
> 
> Hi all,
> 
>         I've searched around for a answer to this with no real luck yet. If anyone
> has some ideas I'd be very grateful.
> 
>         I recently upgraded to a new machine. It is running RedHat 6.2 Linux (with
> a SMP 2.4.0test[8-11] kernel) and has a Matrox G400 in it. X is 4.0.1.
> Anyway, about once every 2-3 days X will spontaneously die and the only info
> I get back is that it was because of signal 11.
>         I've heard that signal 11 can be related to bad hardware, most often
> memory, but I've done a good bit of testing on this and the system seems ok.
> What I did was to run the VA Linux Cerberos(sp?) test for 15 hours+ with no
> errors. Actually this only worked when running from the console. When
> running from X the machine locked up (although no signal 11).
>         The only info I've gotten back from the XFree86 mailing lists so far is
> that there are known and wide spread problems with SMP and these types of
> problems. Can anyone comment on this? Are there known SMP problems? What is
> the current resolution plan?
> 
> Thanks,
> 
> --Rainer
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
