Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUC1AoY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUC1AoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:44:24 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:21688 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S262035AbUC1AoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:44:17 -0500
Date: Sun, 28 Mar 2004 01:43:41 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>, Arjan van de Ven <arjanv@redhat.com>,
       Cameron Patrick <cameron@patrick.wattle.id.au>,
       Michael Frank <mhf@linuxmail.org>,
       Software Suspend - Mailing Lists 
	<swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] lzf license
Message-ID: <20040328004341.GA9258@schmorp.de>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	Pavel Machek <pavel@ucw.cz>, Arjan van de Ven <arjanv@redhat.com>,
	Cameron Patrick <cameron@patrick.wattle.id.au>,
	Michael Frank <mhf@linuxmail.org>,
	Software Suspend - Mailing Lists <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040322182121.GA21521@schmorp.de> <1080166848.2628.3.camel@calvin.wpcb.org.au> <20040325114736.GA300@elf.ucw.cz> <opr49atvpk4evsfm@smtp.pacific.net.th> <20040322094053.GO16890@patrick.wattle.id.au> <1079948988.5296.8.camel@laptop.fenrus.com> <20040322182121.GA21521@schmorp.de> <1080166848.2628.3.camel@calvin.wpcb.org.au> <20040325142654.GA11633@schmorp.de> <20040325145639.GH1505@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325145639.GH1505@openzaurus.ucw.cz>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 03:56:39PM +0100, Pavel Machek <pavel@suse.cz> wrote:
> > If there are problems with that, I'd like to hear. I see no point in
> > keeping the code out just because it isn't gpl, but I don't see a point
> > in making the original distribution dual licensed for no reason. (and, as
> > I said, there is lots of bsd-derived code in the kernel and I am _really_
> > keen on getting rid of any problems that forbid relicensing).
> 
> So if Nigel takes the BSD license out and replaces it with GPL,
> thats okay with you?

Yes. I believe this was always possible, and should now be rather explicit
with the changes I made.

However, I do not endorse it nor can I see why this should be necessary,
as other parts of the kernel are distributed with dual licensing left
intact, and I don't see why lzf is special.

But, again, relicensing is now explicitly allowed, I am aware of the
fact that this means that one can replace the license with GPL-only and
explicitly allow this happen with or without my consent. This was a
conscious decision etc.. etc.. :)

I hope it'sclear now that relicensing can happen anytime if necessary,
regardless of what my opinion on this is. I also don't need any further
explanations (unless you want to) and would hope that this issue is now
solved and fixing/merging plans can now continue.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
