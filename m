Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133077AbRDLIuz>; Thu, 12 Apr 2001 04:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133078AbRDLIup>; Thu, 12 Apr 2001 04:50:45 -0400
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:53152
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S133077AbRDLIun>; Thu, 12 Apr 2001 04:50:43 -0400
Message-ID: <3AD56C43.84D83889@math.ethz.ch>
Date: Thu, 12 Apr 2001 10:50:11 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@debian.org
X-Mailer: Mozilla 4.75C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.0.0 release announcement
In-Reply-To: <fa.i13tmhv.9kga3t@ifi.uio.no> <fa.g0offov.1jmmkh9@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> > * All three interfaces do progressive disclosure -- the user only sees
> >   questions he/she needs to answer (no more hundreds of greyed-out menu
> >   entries for irrelevant drivers!).
> 
> Well, that sucks. The greyed-out menu entries were the only good
> thing about xconfig.

You are one of the few people that use xconfig... Thus xconfig
is not
so worse as people tell me.

> Such entries provide a clue that you need
> to enable something else to get the feature you desire. Otherwise
> you might figure that the feature is missing, or that you have
> overlooked it.

There is an option (check the menu) to show all entries
(grayed)
and now there is also in make menuconfig this option ('S'
command)

On my extensive test, now all the features of the older tools
are
included. But the important feature to read the old .config
file, but
this feature will be included in the next version (check the
previous
esr's mails)


	giacomo
