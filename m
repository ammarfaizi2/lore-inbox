Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWAaWC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWAaWC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWAaWC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:02:29 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:15834 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1751572AbWAaWC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:02:29 -0500
Message-ID: <43DFDEF9.2030001@keyaccess.nl>
Date: Tue, 31 Jan 2006 23:04:41 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D114A8.4030900@wolfmountaingroup.com>  <20060120111103.2ee5b531@dxpl.pdx.osdl.net>  <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>  <43D7B20D.7040203@wolfmountaingroup.com>  <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com>  <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>  <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>  <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>  <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>  <1138387136.26811.8.camel@localhost>  <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> <1138620390.31089.43.camel@localhost.localdomain> <Pine.LNX.4.64.0601310931540.7301@g5.osdl.org> <43DF9D42.7050802@wolfmountaingroup.com> <Pine.LNX.4.64.0601311032180.7301@g5.osdl.org> <43DFB0F2.4030901@wolfmountaingroup.com> <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Alan argues that that extra notice "changed" the license (and that any 
> code that is older than 5 years would somehow not be GPLv2). I argue 
> otherwise. I argue that for the whole history, Linux has been v2-only 
> unless otherwise explicitly specified.

Hope you don't mind an opinion from a bystander...

I actually believe that Alan Cox is making a fair point, when viewed 
from the perspective of the strict language of the license.

The license as distributed with the kernel itself states that unless the 
program specifies the version of the GPL that it's under, any version 
will do. Alan makes the point that at least upto the 2.4.0-test8 
addition, the program never specified the version, as the "v2" was only 
in the _license_, which is not the _program_.

And this is not a bad point -- the license and the program are indeed 
not the same; they are not even copyrighted by the same people. With the 
addition to the COPYING file, there's something added which clearly is 
yours, but before that it was just the generic GPL, copyrighted by the FSF.

As additional "proof" of the fact that the license can not be considered 
part of "the program" he pointed out that the GPL document in itself is 
not GPL compatible, meaning that under this strict interpretation it 
could even be argued that there would be a legal problem in combining 
this document with the rest of the program.

Sure, I noted all the "intent" stuff, and you may feel an interpretation 
this strict is not sensible, but I really do believe he's making a fair 
point if you do not want to trust the law, and all judges, to always be 
as sensible as you want them to be.

> And I don't think even Alan will argue that the "v2 only" thing
> hasn't been true for the last five years.

I would not at least. The added bit needs to be considered part of the 
program itself, solving the issue.

Rene.

