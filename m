Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272754AbRIGQMW>; Fri, 7 Sep 2001 12:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272756AbRIGQMM>; Fri, 7 Sep 2001 12:12:12 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:32526 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S272754AbRIGQMF>; Fri, 7 Sep 2001 12:12:05 -0400
Date: Fri, 7 Sep 2001 18:12:20 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: "Barry K. Nathan" <barryn@pobox.com>
cc: <_deepfire@mail.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Howl of soul...
In-Reply-To: <20010826220645.6D89BB9F08@pobox.com>
Message-ID: <Pine.LNX.4.33.0109071806120.8745-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Barry K. Nathan wrote:

> > > there's nothing wrong with the chipset/controller; isn't this thread
> > > about the well-known DTLA problem?  if so, then what mode you use
> > > is completely irrelevant, since the physical media is degrading.
> >
> >      i feel like the media isn`t downgrading because
> >  the badblocks _arent_ physical: low-level drive
> >  reformat doesnt show anything.
>
> A low-level format (using IBM DFT) is going to *silently* remap bad
> parts of the disk. It's only going to complain once it's no longer
> possible to remap the bad sectors. So, just because the low-level format
> doesn't complain does not mean that there is no media degradation!
>
> Also, many people seem to be correlating it to heat, and possibly to
> flaws in IBM's implementation of glass platters in these drives. For
> example, see
> http://www.storagereview.com/welcome.pl?/http://www.storagereview.com/jive/sr/thread.jsp?forum=1&thread=16057
>
> -Barry K. Nathan <barryn@pobox.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Just to add something to the noise, I'm so happy with DTLA-307030's
that I'm not even considering buying something different. As I see it,
there's simply no competing product, full stop.  Recently I've bought
a 41Gb 60GXP, and I'm happy with that too.  It is true that I usually
stick with the same HW for a long while, so maybe I'm just being lucky.

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it


