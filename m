Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272002AbRHVNop>; Wed, 22 Aug 2001 09:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272009AbRHVNof>; Wed, 22 Aug 2001 09:44:35 -0400
Received: from borg.org ([208.218.135.231]:8722 "HELO borg.org")
	by vger.kernel.org with SMTP id <S272002AbRHVNo0>;
	Wed, 22 Aug 2001 09:44:26 -0400
Date: Wed, 22 Aug 2001 09:44:40 -0400
From: Kent Borg <kentborg@borg.org>
To: linux-kernel@vger.kernel.org
Subject: State of PPC in kernel.org Sources?
Message-ID: <20010822094440.B11350@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the state of Power PC support in Linus' kernels?  What about
in -ac kernels?  

I have noticed some recent PPC work in summaries of recent -ac kernels
and wonder how intact it is.  Are they merges to keep PPC forks from
drifting too far?  Are they merges to make furture back-ports from
kernel.org to PPC forks easier?  Are they actually complete in and of
themselves but lagging PPC forks?  (What about 405 support?  I think I
see evidence of recent 405 activity in 2.4.8-ac4...)

I would love a short descreiption of the shape of this stuff.  What
work happens where and how and when it moves elsewhere would be great
to understand.  

Thanks a bunch,


-kb, the new-at-this Kent who is working on a 405GP right now, but who
will possibly be moving to a different architecture soon and doesn't
want to be in a PPC-specific ghetto.


P.S.  A terse "Use kernel blah-blah." isn't very useful.  We have a
working kernel already.  I am trying to understand what comes from
where, where it goes, how often, how completely, etc.
