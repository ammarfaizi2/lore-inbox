Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbQLKMiy>; Mon, 11 Dec 2000 07:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130304AbQLKMio>; Mon, 11 Dec 2000 07:38:44 -0500
Received: from d1o974.telia.com ([212.181.169.241]:60175 "EHLO
	d1o974.telia.com") by vger.kernel.org with ESMTP id <S129631AbQLKMif>;
	Mon, 11 Dec 2000 07:38:35 -0500
Date: Mon, 11 Dec 2000 13:08:00 +0100 (CET)
From: Johan Bergström <johbe@telia.com>
To: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
cc: Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11 EXT2 corruption (closed)
In-Reply-To: <20001211092130.A9129@iapetus.localdomain>
Message-ID: <Pine.LNX.3.96.1001211130514.21586A-100000@h193n3fls20o974.telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000, Frank van Maarseveen wrote:

> On Mon, Dec 11, 2000 at 01:37:36AM +0100, Guest section DW wrote:
> > 
> > I see lots of messages from you about corruption in 2.4.0-test11
> > but we all know very well that 2.4.0-test11 corrupts things
> > and further evidence is not necessary.
> > Hopefully all, or at least the most significant, problems
> > have been solved now, so you should upgrade to the most
> > recent test kernel and see how things are there.
> > 
> Thanks. test12-pre7 fixes this for me: it ran all night testing and
> no problems so far.
> 
I'm running test12-pre7 and had a bad lockup a couple of days ago. Or
actually it wasnt a lockup it was a "klonk" in the harddrive when I
started netscape then the machine rebooted. And I had a corruption in the
$HOME/.netscape/cache directory. No logged messages or anything anywhere.
The machine just rebooted and I had to manually fsck /home.

Johan
> -- 
> Frank
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
