Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbVDHRWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVDHRWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVDHRWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:22:35 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7173 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262882AbVDHRUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:20:14 -0400
Date: Fri, 8 Apr 2005 19:20:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Humberto Massa <humberto.massa@almg.gov.br>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050408172010.GC6653@stusta.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Humberto Massa <humberto.massa@almg.gov.br>,
	debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
	linux-kernel@vger.kernel.org
References: <h-GOHD.A.KL.s2aUCB@murphy> <42527E89.4040506@almg.gov.br> <20050405135701.GA24361@pegasos> <20050407205647.GB4325@stusta.de> <20050407210505.GB17963@pegasos> <20050408003136.GI4325@stusta.de> <20050408065440.GC27346@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408065440.GC27346@pegasos>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 08:54:40AM +0200, Sven Luther wrote:
> On Fri, Apr 08, 2005 at 02:31:36AM +0200, Adrian Bunk wrote:
> > On Thu, Apr 07, 2005 at 11:05:05PM +0200, Sven Luther wrote:
> > > On Thu, Apr 07, 2005 at 10:56:47PM +0200, Adrian Bunk wrote:
> > >...
> > > > If your statement was true that Debian must take more care regarding 
> > > > legal risks than commercial distributions, can you explain why Debian 
> > > > exposes the legal risks of distributing software capable of decoding 
> > > > MP3's to all of it's mirrors?
> > > 
> > > I don't know and don't really care. I don't maintain any mp3 player (err,
> > > actually i do, i package quark, but use it mostly to play .oggs, maybe i
> > > should think twice about this now that you made me aware of it), but in any
> > > case, i am part of the debian kernel maintainer team, and as such have a
> > > responsability to get those packages uploaded and past the screening of the
> > > ftp-masters. I believe the planned solution is vastly superior to the current
> > > one of simply removing said firmware blobs from the drivers, which caused more
> > > harm than helped, which is why we are set to clarifying this for the
> > > post-sarge kernels. 
> > 
> > 
> > Debian doesn't seem to care much about the possible legal problems of 
> > patents.
> 
> patents are problematic, and upto recently there where no software patents in
> europe, so i don't really care. I am not sure about the details of the above
> problem you mention, could you provide me some link to the problem at hand. I

  http://www.mp3licensing.com/

The patent problems in the USA alone should impose enough legal risks.
IANAL, but even RedHat considers them to be serious problems.

And note that most of their patents are also valid in the EU. If they 
are enforcible is a different question, but it might be enough to become
a legal risk that a lawsuit might be started against e.g. a mirror.

> also believe that in the larger scheme restriction of this kind, as is the US
> restriction on distribution to cuba and everything else, is not-right and even
> immoral, and *I* personally would fight back if i was ever sued for such
> things, and there may be higher courts involved than just the US judicial
> system, which is for sale anyway, where redhat is dependent on. I cannot talk

Which court is "higher ... than just the US judicial system"?

If you are in the USA, there's no legal instance between the US supreme 
court and god.

> about the whole of debian on this though, and i feel it is for someone else to
> tackle and handle. If you feel strongly about this, you are free to go take it
> over with whoever handles this, post to debian-legal and debian-project about
> it, and help get the issue solved.
> 
> (/me believes such restrictions of the above are a violation of the elemental
> human rights to go where one wants and run what operating system on wants).
>...

Unfortunately, life isn't fair.

It's Debian's choice how cautiously or brave they are regarding legal 
risks. But it has to be consistent.

Debian simply needs an overall policy for this.

But if you say that you want to avoid any legal risks in one area while 
saying "these are not my packages" about perhaps even more likely legal 
risks in other areas doesn't help anyone.

> Friendly,
> 
> Sven Luther

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

