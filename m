Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281371AbRKLJ4x>; Mon, 12 Nov 2001 04:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281391AbRKLJ4n>; Mon, 12 Nov 2001 04:56:43 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:20610 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S281371AbRKLJ4a>;
	Mon, 12 Nov 2001 04:56:30 -0500
Date: Mon, 12 Nov 2001 01:38:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: Thomas Foerster <puckwork@madz.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Module / Patch with implements "sshfs"
Message-ID: <20011112013828.A359@elf.ucw.cz>
In-Reply-To: <20011109152819Z279925-17408+12662@vger.kernel.org> <200111110040.fAB0eDZ13820@maile.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200111110040.fAB0eDZ13820@maile.telia.com>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> A simpler way is to use the kio_fish
>  http://apps.kde.com/na/2/info/id/1331
> (I had problem with compiling this under SuSE 7.1 but with
> SuSE 7.3 there were no problems)
> 
> You browsing will look like:
>  fish://192.168.9.99/home/
> compare with
>  ftp://ftp.kernel.org/
> 
> And since it is KDE all KDE programs will be able to use it :-)
> (To be sure I tried to create a file with advanced editor and save it
>  remote - it worked! :-)
> 
> KDE port done by: Jörg Walter
> Originally for mc by: Pavel Machek

And if you use uservfs (.sourceforge.net), all programs can do
that. As good as if it was kernelspace, but it stays userland.
								Pavel

-- 
STOP THE WAR! Someone killed innocent Americans. That does not give
U.S. right to kill people in Afganistan.


