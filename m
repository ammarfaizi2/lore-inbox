Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313505AbSEYEtf>; Sat, 25 May 2002 00:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSEYEte>; Sat, 25 May 2002 00:49:34 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:27151 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S313505AbSEYEtd>; Sat, 25 May 2002 00:49:33 -0400
Message-ID: <3CEF1780.95C7CE66@opersys.com>
Date: Sat, 25 May 2002 00:48:00 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205241440210.28644-100000@home.transmeta.com> <3CEEC729.74625C2B@opersys.com> <20020524162228.D28795@work.bitmover.com> <3CEF139A.1572367C@opersys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Karim Yaghmour wrote:
> > I'll bet that is the cause of all the confusion.  The patent and the
> > GPL have no correlation.  It's completely up to FSMlabs to define what
> > is an application and what is not.  And it's a very reasonable thing
> > for them to consider everything which runs on top of the RTLinux substrate
> > to be required to be covered by the GPL.  That's certainly within their
> > rights.
> 
> It most certainly is. I have no disagreement with you there.

Actually, I forgot something here. The way patent law works is that they
don't have power on anything that doesn't implement their patent. RT
tasks don't implement any part of their patent and _should_, therefore,
not be subject to their patent. You can dislike Eben, but here's what
he had to say about this particular issue:
"Anything which is not part of the patent's claims is not covered by
the patent, and can be done by anyone anywhere anytime, without regard
to the patent."

Since RT tasks haven't been patented, it follows that Victor can't
force you to use GPL tasks instead of non-GPL ones. He can, however,
force you to only distribute GPL RTLinux-like microkernels. That
was the essence of Eben's explanation. And, as I understanding, this
isn't really just an "opinion" but really follows from patent law.
But since Victor, Linus and yourself are dismissing his counsel,
rt developers are back to square 1.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
