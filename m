Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276647AbRJKSLa>; Thu, 11 Oct 2001 14:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276653AbRJKSLU>; Thu, 11 Oct 2001 14:11:20 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:22681 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S276643AbRJKSLG>; Thu, 11 Oct 2001 14:11:06 -0400
Date: Thu, 11 Oct 2001 12:08:21 -0600
Message-Id: <200110111808.f9BI8Ls04654@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: John Levon <moz@compsoc.man.ac.uk>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tainting FAQ
In-Reply-To: <20011011184241.A95852@compsoc.man.ac.uk>
In-Reply-To: <20011011184241.A95852@compsoc.man.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon writes:
> short and sweet. (useful) comments ?

Maybe we're giving out too much information? To put it bluntly, if
people are told what we're up to, they'll doctor the bug reports.
People are selfish and will try to game the system. I'm not even sure
if we should expose the term "tainted" in the first place. Maybe a
"compatibility bitmask" with a hex value should be reported instead.

Alan: you're the instigator of this scheme. How widely do you want to
publish what this is really about? I note that lwn.net had a paragraph
on the tainting scheme.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
