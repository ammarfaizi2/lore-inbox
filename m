Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286661AbRL1BiC>; Thu, 27 Dec 2001 20:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286665AbRL1Bhx>; Thu, 27 Dec 2001 20:37:53 -0500
Received: from bitmover.com ([192.132.92.2]:60063 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S286661AbRL1Bhq>;
	Thu, 27 Dec 2001 20:37:46 -0500
Date: Thu, 27 Dec 2001 17:37:39 -0800
From: Larry McVoy <lm@bitmover.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011227173739.U25698@work.bitmover.com>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011227171545.T25698@work.bitmover.com> <18619.1009503350@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <18619.1009503350@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Fri, Dec 28, 2001 at 12:35:50PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 12:35:50PM +1100, Keith Owens wrote:
> On Thu, 27 Dec 2001 17:15:45 -0800, 
> Larry McVoy <lm@bitmover.com> wrote:
> >[talking about kbuild 2.5 speed]
> >Then it does seem reasonable to ask that the new one is at least as fast
> >as the old one.
> 
> kbuild 2.4 is fast but inaccurate, kbuild 2.5 is slower but accurate.
> Pick one.
> 
> I am sure that I can speed up kbuild 2.5 with a rewrite of the core
> code but I am staying on stable code to send to Linus.

A couple of questions:

a) will 2.5 be as fast as the current system?  Faster?
b) what's the eta on 2.5?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
