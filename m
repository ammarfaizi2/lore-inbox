Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUBQAQc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 19:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbUBQAQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 19:16:32 -0500
Received: from mail.tmr.com ([216.238.38.203]:6670 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261575AbUBQAQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 19:16:30 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] remove obsolete onstream support from ide-tape in
 2.6.3-rc3
Date: 17 Feb 2004 00:15:38 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <c0rmfa$453$1@gatekeeper.tmr.com>
References: <20040215221108.GA4957@serve.riede.org> <20040215153214.002dcc9a.pj@sgi.com>
X-Trace: gatekeeper.tmr.com 1076976938 4259 192.168.12.62 (17 Feb 2004 00:15:38 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040215153214.002dcc9a.pj@sgi.com>,
Paul Jackson  <pj@sgi.com> wrote:
| And another obsolete tape drive goes on my vintage shelf.
| 
| Willem - I notice off SourceForge a note:
| 
|   http://sourceforge.net/forum/forum.php?forum_id=333748
| 
|   Posted By: wriede
|   Date: 2003-12-01 16:24
|   Summary: osst, the Linux OnStream Tape driver now avalable on sf.net
| 
|   Following the unfortunate bankruptcy of OnStream, I have now completed
|   the migration of the osst CVS repository, web site and mailing list to
|   SourceForge.
| 
|   Willem Riede,
|   osst maintainer.
| 
| How does this relate to your removal of onstream from 2.6?  I'm guessing
| that you are maintaining onstream in 2.4, but not in 2.6 or beyond.  But
| that's just a guess.
| 
| With onstream tape cartridges selling for (another guess - can't
| actually _find_ any for sale anymore) at $4/Gbyte, and IDE drives at
| under $1/Gbyte, using removable drives for backup makes more sense than
| using onstream, anyway I can see to cut it.  And the chances of the IDE
| interface going obsolete anytime soon seem refreshingly small.

Of course the chances of parallel IDE controllers going obsolete are
higher. Archival storage seems to be more and more of a problem as
hardware improves. I'm copying the contents of my old SCSI hard drives
to CD (they fit), my old tapes to various media, and generally getting
stuff current, but as soon as I stop making the effort I know my ability
to read old stuff will vanish. Try and find devices for 8 inch floppies
or even 5-1/4, and most systems don't come with 3-1/2 any more.

My old "standard" tapes are being backed up on new media, my records and
old tapes to newer media, etc. We are getting close to the point where
we have room to store everything, but can't read anything more than
about a decade old.

Disk drives are cheap, but sensitive to temperature, vibration, magnetic
field, and age. The life of optical is debated, and entropy is winning
quickly. I don't have a solution, but I'm glad there is any working
driver for old hardware!
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
