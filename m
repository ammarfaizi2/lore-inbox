Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbREVPpY>; Tue, 22 May 2001 11:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261940AbREVPpQ>; Tue, 22 May 2001 11:45:16 -0400
Received: from dhcp04.gb.nrao.edu ([192.33.116.206]:5636 "EHLO
	mobilix.atnf.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S261892AbREVPpF>; Tue, 22 May 2001 11:45:05 -0400
Date: Tue, 22 May 2001 09:06:25 -0400
Message-Id: <200105221306.f4MD6Pi00360@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-net@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-hams@vger.kernel.org>,
        <linux-ppp@vger.kernel.org>
Subject: Re: ECN is on!
In-Reply-To: <Pine.LNX.4.30.0105220649530.17291-100000@biglinux.tccw.wku.edu>
In-Reply-To: <15114.18990.597124.656559@pizda.ninka.net>
	<Pine.LNX.4.30.0105220649530.17291-100000@biglinux.tccw.wku.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent D. Norris writes:
> > I veto, the whole point of moving to ECN was to make a statement and
> > get people to fix their kit.
> >
> > We will remove these people, that's all.
> 
> Isn't this a problem though because the messge saying that ECN was
> enabled was set after ECN was enabled?  Thus these people have no
> idea what is going on and they probably won't know what to fix until
> they do.

Dave sent a message out a week or two ago saying he was going to do it
soon. And back in January he said he'd be doing it in February. The
kernel list FAQ has stated this right at the top, in big, bright red
letters. Yesterday, after I saw Dave's announcement, I updated the FAQ
to reflect that we're now running ECN.

People have had plenty of warning. Think of it as a bonus that it
didn't happen back in February. They've had an extra 3 months to sort
something out.

I note with disgust the number of places which should know better, but
still haven't fixed their kit. Most appalling was
missionalcriticallinux.com. Shame!

Sure, Dave is being bloody-minded, but that's the only way we'll see
people get off their fat, lazy asses and fix their broken systems.
In fact, hopefully he's still in a dark mood, and he may take up the
suggestion to bounce mails of the following type:
- MIME encoded
- HTML encoded
- quoted printables (those stupid "=20" things are particuarly hard to
  read).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
