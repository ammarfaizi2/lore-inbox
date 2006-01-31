Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWAaXsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWAaXsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWAaXsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:48:22 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56448 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751084AbWAaXsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:48:21 -0500
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com>
	 <20060120111103.2ee5b531@dxpl.pdx.osdl.net>
	 <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>
	 <43D7B20D.7040203@wolfmountaingroup.com>
	 <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com>
	 <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
	 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
	 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
	 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>
	 <1138387136.26811.8.camel@localhost>
	 <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org>
	 <1138620390.31089.43.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0601310931540.7301@g5.osdl.org>
	 <43DF9D42.7050802@wolfmountaingroup.com>
	 <Pine.LNX.4.64.0601311032180.7301@g5.osdl.org>
	 <43DFB0F2.4030901@wolfmountaingroup.com>
	 <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Jan 2006 23:48:38 +0000
Message-Id: <1138751318.10316.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-31 at 12:38 -0800, Linus Torvalds wrote:
> Alan argues that that extra notice "changed" the license (and that any 
> code that is older than 5 years would somehow not be GPLv2). I argue 
> otherwise. I argue that for the whole history, Linux has been v2-only 
> unless otherwise explicitly specified.
> 
> And I don't think even Alan will argue that the "v2 only" thing hasn't 
> been true for the last five years.

I would argue its irrelevance

Two cases (lets call them a and b)

	a) The GPLv2 only was always the case
	b) There was no version so it was open to choice

Which ultimately means either

	a) Linus changed nothing
	b) Linus chose a version as the License allowed him to in accordance
with section 9.

So we have two legal outcomes both of which produce the right answer for
any vaguely recent source tree. At which point does it matter ?

My point was to make clear that assuming the GPL original text implies
the version of the code is wrong, and explain why the FSF recommend the
long text.

Is there doubt about the license status of the current code - not in
this area, no. The COPYING file is extremely clear on this, and more
importantly in other possible unclear and problematic areas. For example
the statement that the system calls are not derivative statement which
resolves the biggest interpretation concern of all.

Alan

