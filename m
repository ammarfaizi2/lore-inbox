Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280760AbRKKAkj>; Sat, 10 Nov 2001 19:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280761AbRKKAk2>; Sat, 10 Nov 2001 19:40:28 -0500
Received: from maile.telia.com ([194.22.190.16]:56296 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S280760AbRKKAkQ>;
	Sat, 10 Nov 2001 19:40:16 -0500
Message-Id: <200111110040.fAB0eDZ13820@maile.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Thomas Foerster <puckwork@madz.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Module / Patch with implements "sshfs"
Date: Sun, 11 Nov 2001 01:38:25 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20011109152819Z279925-17408+12662@vger.kernel.org>
In-Reply-To: <20011109152819Z279925-17408+12662@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A simpler way is to use the kio_fish
 http://apps.kde.com/na/2/info/id/1331
(I had problem with compiling this under SuSE 7.1 but with
SuSE 7.3 there were no problems)

You browsing will look like:
 fish://192.168.9.99/home/
compare with
 ftp://ftp.kernel.org/

And since it is KDE all KDE programs will be able to use it :-)
(To be sure I tried to create a file with advanced editor and save it
 remote - it worked! :-)

KDE port done by: Jörg Walter
Originally for mc by: Pavel Machek
 
/RogerL

On Friday 09 November 2001 16:26, Thomas Foerster wrote:
> Hi folks,
>
> i came across the idea to mount a remote filesystem via SSH[1|2].
>
> I've seen a free program for Windows that implements parts of what i'm
> thinking of.
>
> Does someone know about a kernel module/patch to implement a "sshfs" ?
> (to be used with mount)
>
> What i want to do is to mount my webserver (external ip) from an internal
> system (internal ip).
>
> Thanks,
>   Thomas
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Roger Larsson
Skellefteå
Sweden
