Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVDNN5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVDNN5Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 09:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVDNN5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 09:57:24 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:8459 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261505AbVDNN5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 09:57:17 -0400
Message-ID: <425E77BB.5010902@aitel.hist.no>
Date: Thu, 14 Apr 2005 16:01:31 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Exploit in 2.6 kernels
References: <1113298455.16274.72.camel@caveman.xisl.com> <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com> <20050412210857.GT11199@shell0.pdx.osdl.net> <1113341579.3105.63.camel@caveman.xisl.com> <425CEAC2.1050306@aitel.hist.no> <20050413125921.GN17865@csclub.uwaterloo.ca> <20050413130646.GF32354@marowsky-bree.de> <20050413132308.GP17865@csclub.uwaterloo.ca> <425D3924.1070809@nortel.com>
In-Reply-To: <425D3924.1070809@nortel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> Lennart Sorensen wrote:
>
>> Graphics card companies don't realize they are hardware companies not
>> software companies and that it is hardware they make their money from?
>> Oh and they have too many lawyers?
>
>
> This has been mentioned before, but I'll say it again.
>
> Nvidia has intellectual property from *other companies* in their 
> drivers/hardware.
>
> They are *not allowed* to make the specs public due to their 
> agreements with those other companies.
>
> It's that simple.

That argument isn't very good.  It'd be quite bad if all the "intellectual
property" was Nvidia's own.  Then we'd complain that they could
simply release the specs instead of keeping them secret for no
good reason.

Of course my argument applies equally well when there is several
companies invloved.  Why can't they give us specs instead of keeping
them secret for no good reason???  The fact that nvidia isn't free
to do this _on their own_ doesn't change anything. The companies can
act together and release necessary information for the drm people.

Nvidia can, for example, tell their "ip"-partners that the specs is wanted
ant try to get a licence for handing out what's needed.  Or the other way
around - the "other companies" may want more sales of their stuff
and tell nvidia they want specs released to open-source developers. Or
simply release information about "their own" part of the card.

And for those that want to keep some things secret - they may not have 
to open
up all information - only enough to get a driver made.  For example:
"write this sequence of magic bytes to these registers in order to set
up some pipeline."  It tells how to get things done, but not every detail.
A driver based on such information might not be the best, but it
could possible be enough - and certainly better than nothing.

Helge Hafting






