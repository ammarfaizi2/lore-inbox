Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUCYOaC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUCYOaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:30:01 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:53675 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S263162AbUCYO1s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:27:48 -0500
Date: Thu, 25 Mar 2004 15:26:54 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Cameron Patrick <cameron@patrick.wattle.id.au>,
       Michael Frank <mhf@linuxmail.org>, Pavel Machek <pavel@suse.cz>,
       Software Suspend - Mailing Lists 
	<swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] lzf license
Message-ID: <20040325142654.GA11633@schmorp.de>
Mail-Followup-To: Nigel Cunningham <ncunningham@users.sourceforge.net>,
	Pavel Machek <pavel@ucw.cz>, Arjan van de Ven <arjanv@redhat.com>,
	Cameron Patrick <cameron@patrick.wattle.id.au>,
	Michael Frank <mhf@linuxmail.org>, Pavel Machek <pavel@suse.cz>,
	Software Suspend - Mailing Lists <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040322094053.GO16890@patrick.wattle.id.au> <1079948988.5296.8.camel@laptop.fenrus.com> <20040322182121.GA21521@schmorp.de> <1080166848.2628.3.camel@calvin.wpcb.org.au> <20040325114736.GA300@elf.ucw.cz> <opr49atvpk4evsfm@smtp.pacific.net.th> <20040322094053.GO16890@patrick.wattle.id.au> <1079948988.5296.8.camel@laptop.fenrus.com> <20040322182121.GA21521@schmorp.de> <1080166848.2628.3.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325114736.GA300@elf.ucw.cz> <1080166848.2628.3.camel@calvin.wpcb.org.au>
X-Operating-System: Linux version 2.6.4 (root@cerebro) (gcc version 3.3.3 20040125 (prerelease) (Debian)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 10:20:48AM +1200, Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:
> I'm not sure what the verdict is in the end. Do we need changes to the
> license? If so, could you send me a patch, Marc?

I have no idea. I made an offer on how to change the license, if that
isn't ok, I'd like to hear.

On Thu, Mar 25, 2004 at 12:47:37PM +0100, Pavel Machek <pavel@ucw.cz> wrote:
> Linking BSD w/o advertising with kernel is okay, but it would taint
> the kernel, and is bad idea w.r.t. patents, anyway. Dual BSD/GPL is
> better way to go.

Well, if there is any problem with relicensing the code as GPL, let me
know. I offered to change the license to make this smoother, but lots of
kernel code came from a bsd license and was relicensed before.

If there are problems with that, I'd like to hear. I see no point in
keeping the code out just because it isn't gpl, but I don't see a point
in making the original distribution dual licensed for no reason. (and, as
I said, there is lots of bsd-derived code in the kernel and I am _really_
keen on getting rid of any problems that forbid relicensing).

I am now back from the cebit and much more responsive, btw.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
