Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285574AbRL1BQL>; Thu, 27 Dec 2001 20:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285143AbRL1BQB>; Thu, 27 Dec 2001 20:16:01 -0500
Received: from bitmover.com ([192.132.92.2]:49055 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284017AbRL1BPw>;
	Thu, 27 Dec 2001 20:15:52 -0500
Date: Thu, 27 Dec 2001 17:15:45 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20011227171545.T25698@work.bitmover.com>
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200112280024.fBS0OYH26337@snark.thyrsus.com> <Pine.LNX.4.33.0112280147290.18346-100000@Appserv.suse.de> <20011227195738.A26889@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011227195738.A26889@thyrsus.com>; from esr@thyrsus.com on Thu, Dec 27, 2001 at 07:57:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 07:57:38PM -0500, Eric S. Raymond wrote:
> Dave Jones <davej@suse.de>:
> >                                     Maybe keep them both in the
> > tree until this issue is worked out ? That way those who want to
> > play with kbuild can do so, and those who build a few dozen
> > kernels a day don't have to twiddle thumbs.
> 
> That is such an unutterably horrible concept that the very tentacles
> of Cthulhu himself must twitch in dread at the thought.  The last thing
> anyone sane wants to do is have to maintain two parallel build systems
> at the same time.

Then it does seem reasonable to ask that the new one is at least as fast
as the old one.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
