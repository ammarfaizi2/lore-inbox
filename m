Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279189AbRJWBnQ>; Mon, 22 Oct 2001 21:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279187AbRJWBm4>; Mon, 22 Oct 2001 21:42:56 -0400
Received: from alcove.wittsend.com ([130.205.0.10]:26054 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S279185AbRJWBmv>; Mon, 22 Oct 2001 21:42:51 -0400
Date: Mon, 22 Oct 2001 21:43:24 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
Message-ID: <20011022214324.A18888@alcove.wittsend.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011022172742.B445@virtucon.warpcore.org> <E15vnuN-0003jW-00@the-village.bc.nu> <20011022203159.A20411@virtucon.warpcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011022203159.A20411@virtucon.warpcore.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 08:31:59PM -0500, drevil@warpcore.org wrote:
> On Mon, Oct 22, 2001 at 11:50:59PM +0100, Alan Cox wrote:
> > I can't debug Nvidia's code even to see why it might have broken. Its as
> > simple as that - no politics, no agenda on them opening it, simple technical
> > statement of fact.

> On one side I can see this, on the other I can't. For example, no matter how
> many times a user visits windows update, chances are his drivers will still work
> with his current version of windows. Admittedly, some may not consider this a

	Really?  Sure as hell hasn't been my experience.  Oh!  That only
works with Windows 95!  Ok, now you can get the driver to support Windows
98 but it won't support Windows NT (got one RIGHT NOW like that).  Oops,
you upgraded to Windows 2000, can't support that with that driver, we
don't have a driver for that yet.  Windows XP, sorry, we don't have the
Windows XP certified driver, yet, try back in a few months.

	Think that's a joke?  I think it's pathetic and it is EXACTLY
what I have experienced with multimedia cards, scanners, and printers.

> feature, but I think a lot do. Why should a 'stable' kernel series break
> existing drivers?

	Why would Windows XP break all the non-MS Windows 2000 drivers
(don't you dare tell me it didn't, I work at a place that got slammed by
their shit).  Why would things that work on Windows 98 (Delorme Eartha
DVD) not work on Windows NT or Windows 2000.  The Windows mess is a swamp
out there of what drivers work with what version (some don't even work
between the original editions and updated editions - Windows 95 had
three editions that I have in hand).

> > I really doubt Nvidia will open their driver code. I've heard them explain
> > some of the reasons they don't and in part they make complete sense.

> Microsoft deals with companies that won't always give them access to the drivers
> directly, but often they will tell users workarounds, or at least attempt to
> gather enough knowledge since they are tehnically the OS vendor to give to the
> driver provider to fix the problem. If you are the OS provider, and a change you
> make breaks user drivers/programs generally I think it's a polite gesture to at
> least attempt to find out what's going on and then pass that information on to
> the people who can properly handle it...

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

