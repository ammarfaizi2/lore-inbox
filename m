Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSIIIke>; Mon, 9 Sep 2002 04:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSIIIke>; Mon, 9 Sep 2002 04:40:34 -0400
Received: from [212.3.242.3] ([212.3.242.3]:47350 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S316615AbSIIIke>;
	Mon, 9 Sep 2002 04:40:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Kristian Peters <kristian.peters@korseby.net>
Subject: Re: linux 2.4.20-ac patches
Date: Mon, 9 Sep 2002 10:42:33 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200209090847.32334.devilkin-lkml@blindguardian.org> <20020909102000.56e94334.kristian.peters@korseby.net>
In-Reply-To: <20020909102000.56e94334.kristian.peters@korseby.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209091042.33304.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 10:20, Kristian Peters wrote:
> DevilKin <devilkin-lkml@blindguardian.org> schrieb:
> > Since then if I ever attempt to access the cdrom (which is used through
> > /dev/sr1 using ide-scsi) i get an oops. After that, I get errors from the
> > SCSI layer talking about timeouts and retries.
>
> Please have a look at the "Linux 2.4.20-pre5-ac4" thread. Exactly your
> problem was also noticed by 2 other people.

OK. Weird thing is that it worked perfectly earlier (i'm using the same kernel 
config as before my reinstall).

I'll verify the versions of all packages installed before (i have a list of 
pkgname+version) and installed now, and see if i spot any differences that 
might cause this.

DK
-- 
Kiss your keyboard goodbye!

