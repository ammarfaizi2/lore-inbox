Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbTAEWFf>; Sun, 5 Jan 2003 17:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbTAEWFf>; Sun, 5 Jan 2003 17:05:35 -0500
Received: from auto-matic.ca ([216.209.85.42]:14353 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265382AbTAEWFe>;
	Sun, 5 Jan 2003 17:05:34 -0500
Date: Sun, 5 Jan 2003 17:22:35 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is Nvidia given GPL'd code to use in non-free drivers?
Message-ID: <20030105222235.GB31840@mark.mielke.cc>
References: <20030102013736.GA2708@gnuppy.monkey.org> <Pine.LNX.4.44.0301020245080.8691-100000@fogarty.jakma.org> <20030102055859.GA3991@gnuppy.monkey.org> <20030102061430.GA23276@mark.mielke.cc> <E18UIZS-0006Cr-00@fencepost.gnu.org> <20030103075134.GA31357@mark.mielke.cc> <E18UYSe-0004v1-00@fencepost.gnu.org> <20030104011926.GB4472@mark.mielke.cc> <ava8bs$gbi$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ava8bs$gbi$1@forge.intermeta.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 09:33:48PM +0000, Henning P. Schmiedehausen wrote:
> Mark Mielke <mark@mark.mielke.cc> writes:
> >I have the freedom to use Linux and ClearCase. If closed source modules
> >were to be disallowed, it would be illegal for me to use this configuration,
> >and I would be forced to use HP-UX or Solaris, and not Linux.
> No, it wouldn't. Thats' what most people don't understand. You
> wouldn't have a license to GIVE AWAY a system which consists of Linux
> kernel and MVFS object module.
> ...

Just to point out - I said "If closed source modules were to be disallowed,".

Also - the question isn't whether closed source modules can be distributed,
as much as "can closed source modules that could not be compiled without GPL
source code (header files), be distributed?"

RMS wishes my configuration (Linux + ClearCase MVFS) to be illegal,
because he wishes to enforce an all-free ("free" as defined by RMS)
final product, and the existence of closed-source hardware drivers
(nVidia) or software extensions (ClearCase MVFS) are in the way of
this goal.

If he succeeds, I may lose the freedom to effectively use Linux,
because I don't *mind* buying good software, and I don't *mind* if it
is closed source. Why don't I mind? Because, with few exceptions,
closed source software for expensive price tags tends to be better, or
fuller in some way, in my experience. We live in a capitalist society.
Pretending that capitalism can be avoided is... not realistic.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

