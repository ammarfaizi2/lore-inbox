Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135669AbRBEUUz>; Mon, 5 Feb 2001 15:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135668AbRBEUUp>; Mon, 5 Feb 2001 15:20:45 -0500
Received: from ironsides.terrabox.com ([64.242.77.131]:54938 "EHLO
	ironsides.terrabox.com") by vger.kernel.org with ESMTP
	id <S129929AbRBEUU0>; Mon, 5 Feb 2001 15:20:26 -0500
From: Brian Wolfe <ahzz@terrabox.com>
Date: Mon, 5 Feb 2001 14:19:57 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Wolfe <ahzz@terrabox.com>, Hans Reiser <reiser@namesys.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
Message-ID: <20010205141957.B8950@ironsides.terrabox.com>
In-Reply-To: <20010204205013.D23921@ironsides.terrabox.com> <E14PkEo-0003B2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14PkEo-0003B2-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 05, 2001 at 11:55:16AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Oh believe ,e I agree. But here we run into the dilbert principal and we really should be sarter than the IT Diredtor that makes stupid decisions and overrides thier admins with insane schedules that prevent a full reading of the docs. 8-( Believe me, it's far more common a situation than you would ever expect.

	Brian

On Mon, Feb 05, 2001 at 11:55:16AM +0000, Alan Cox wrote:
> > administrator that has worked in large multi hundred million dollar compani=
> > es where 1 hour of downtime =3D=3D $75,000 in lost income proactive prevent=
> > ion IS the right answer. If the gcc people need to compile with the .96 rh =
> > version then they can apply a removal patch hans provides in the crash mess=
> > age. This makes it easy to remove the safeguard and blow yourself up at wil=
> > l after being suitibly called a dumbass.
> 
> With all due respect, if you are running $75,000/hr of lost income (which btw
> is small fry to a lot of folks) shouldn't you have an engineering team who
> a) read the documentation. 
> b) run tests before rolling out software
> 
> Alan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
