Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267895AbTBLTW7>; Wed, 12 Feb 2003 14:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267896AbTBLTW6>; Wed, 12 Feb 2003 14:22:58 -0500
Received: from master.softaplic.com.br ([200.162.94.241]:19248 "EHLO
	master.softaplic.com.br") by vger.kernel.org with ESMTP
	id <S267895AbTBLTW5>; Wed, 12 Feb 2003 14:22:57 -0500
Date: Wed, 12 Feb 2003 17:33:00 -0200
From: Edesio Costa e Silva <edesio@softaplic.com.br>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Edesio Costa e Silva <edesio@task.com.br>
Subject: Re: 2.5.60 cheerleading...
Message-ID: <20030212173300.A31055@master.softaplic.com.br>
Reply-To: Edesio Costa e Silva <edesio@ieee.org>
References: <3E4A6DBD.8050004@pobox.com> <1045075415.22295.46.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1045075415.22295.46.camel@plars>; from plars@linuxtestproject.org on Wed, Feb 12, 2003 at 12:43:34PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 12:43:34PM -0600, Paul Larson wrote:
> This brings up an interesting point.  It seems like it's very common to
> have a release that doesn't boot, or produces immediately obvious
> problems.  I'm curious if you do any testing (LTP or otherwise) on the
> kernels you intend to release.

In the words of our fearless leader:

    "regression testing"? What's that? If it compiles, it is good,
    if it boots up it is perfect.

:-)

>                                If not, would it be possible for someone
> to do this?  I know we could never catch every problem, but at least the
> annoying, immediately noticeable problems could be caught and fixed
> quickly.
> 
> If you wanted to do this, I think that would be great.  If you don't
> have time, I understand but would you be ok with me or anyone else doing
> at least a quick sniff test before release?  It doesn't have to be
> anything fancy or time consuming.  I'm not looking to add delays, just a
> small amount of extra testing before release so that hopefully more
> people will be willing to try the releases on their systems.
> 
> Thanks,
> Paul Larson
> 
> On Wed, 2003-02-12 at 09:52, Jeff Garzik wrote:
> > Just to counteract all the 2.5.60 bug reports...
> > 
> > After the akpm wave of compile fixes, I booted 2.5.60-BK on my Wal-Mart 
> > PC [via epia], and ran LTP on it, while also stressing it using 
> > fsx-linux in another window.  The LTP run showed a few minor failures, 
> > but overall 2.5.60-BK is surviving just fine, and with no corruption.
> > 
> > So, it's working great for me :)
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 



-- 
Grief can take care of itself, but to get the full value of a joy you must
have somebody to divide it with. -- Mark Twain
