Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281382AbRKLMn2>; Mon, 12 Nov 2001 07:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281383AbRKLMnU>; Mon, 12 Nov 2001 07:43:20 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:3200 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S281382AbRKLMnK> convert rfc822-to-8bit; Mon, 12 Nov 2001 07:43:10 -0500
Date: Mon, 12 Nov 2001 07:42:39 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Pavel Machek <pavel@suse.cz>
cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Thomas Foerster <puckwork@madz.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Module / Patch with implements "sshfs"
In-Reply-To: <20011112013828.A359@elf.ucw.cz>
Message-ID: <Pine.LNX.4.40.0111120741490.579-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Pavel ,  Does uservfs support encryption without /dev/loop ?
		Tia ,  JImL

On Mon, 12 Nov 2001, Pavel Machek wrote:

> Hi!
>
> > A simpler way is to use the kio_fish
> >  http://apps.kde.com/na/2/info/id/1331
> > (I had problem with compiling this under SuSE 7.1 but with
> > SuSE 7.3 there were no problems)
> >
> > You browsing will look like:
> >  fish://192.168.9.99/home/
> > compare with
> >  ftp://ftp.kernel.org/
> >
> > And since it is KDE all KDE programs will be able to use it :-)
> > (To be sure I tried to create a file with advanced editor and save it
> >  remote - it worked! :-)
> >
> > KDE port done by: Jörg Walter
> > Originally for mc by: Pavel Machek
>
> And if you use uservfs (.sourceforge.net), all programs can do
> that. As good as if it was kernelspace, but it stays userland.
> 								Pavel
>
> --
> STOP THE WAR! Someone killed innocent Americans. That does not give
> U.S. right to kill people in Afganistan.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

