Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275843AbRJVTM7>; Mon, 22 Oct 2001 15:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277686AbRJVTMx>; Mon, 22 Oct 2001 15:12:53 -0400
Received: from kiln.isn.net ([198.167.161.1]:30995 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S275843AbRJVTMh>;
	Mon, 22 Oct 2001 15:12:37 -0400
Message-ID: <3BD46FB8.ABAD4EDD@isn.net>
Date: Mon, 22 Oct 2001 16:12:56 -0300
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.13-pre4 i586)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: can't boot 2.4.13-pre6
In-Reply-To: <3BD37F94.95FBB87F@isn.net>
		<20011022141607.058cca0c.sfr@canb.auug.org.au>
		<3BD3A337.CB20ECA1@isn.net> <20011022152539.13e3450a.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> 
> Hi Garst,
> 
> On Mon, 22 Oct 2001 01:40:23 -0300 "Garst R. Reese" <reese@isn.net> wrote:
> >
> > Hi again Stephen,
> > I just rebooted to check again.
> > It says loading linux......................
> > No other msgs.
> > Hope this helps.
> > Garst
> 
> Looks like it is dying very early in the kernel initialisation.  The APM init code hasn't changed, so it is probably something else.  Sorry.
> 
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
Thanks,
Looks like there were kernel setup patches that did not make the
ChangeLog.
Garst
