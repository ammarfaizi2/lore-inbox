Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277700AbRJLOMi>; Fri, 12 Oct 2001 10:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277702AbRJLOMS>; Fri, 12 Oct 2001 10:12:18 -0400
Received: from borg.org ([208.218.135.231]:47110 "HELO borg.org")
	by vger.kernel.org with SMTP id <S277700AbRJLOML>;
	Fri, 12 Oct 2001 10:12:11 -0400
Date: Fri, 12 Oct 2001 10:12:42 -0400
From: Kent Borg <kentborg@borg.org>
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
Subject: kapm-idled Funny in 2.4.10-ac12?
Message-ID: <20011012101242.C19336@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not that it so far appears to be a problem, but where kapm-idled used
to wait a tad after activity and then apparently gobble up all the
extra CPU cycles (in 2.4.10-ac1) I now notice that xosview is showing
CPU usage when things are quiet as hopping up and down, and top is
reporting kapm-idled CPU usage as in the mid to high 50 percent range.

Under 2.4.10-ac1 top used to put kapm-idled in the very high 90
percent range.

Does this mean my laptop will get less battery life?


Thanks,

-kb, the Kent with too wimpy a battery as it is.


P.S.  I am on a Sony Viao PCG-Z505LE.
