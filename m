Return-Path: <linux-kernel-owner+w=401wt.eu-S1750994AbWLXL6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWLXL6V (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 06:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWLXL6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 06:58:21 -0500
Received: from ms-smtp-06.tampabay.rr.com ([65.32.5.136]:41467 "EHLO
	ms-smtp-06.tampabay.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750939AbWLXL6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 06:58:20 -0500
Message-ID: <458E6B46.2060201@cfl.rr.com>
Date: Sun, 24 Dec 2006 06:57:58 -0500
From: Mark Hounschell <dmarkh@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <45811AA6.1070508@superbug.co.uk>
In-Reply-To: <45811AA6.1070508@superbug.co.uk>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> 
> I agree with Linus on these points. The kernel should not be enforcing
> these issues. Leave the lawyers to do that bit. If companies want to
> play in the "Grey Area", then it is at their own risk. Binary drivers
> are already difficult and expensive for the companies because they have
> to keep updating them as we change the kernel versions. If they do open
> source drivers, we update them for them as we change the kernel
> versions, so it works out cheaper for the companies involved.
> 

Hum. We open sourced our drivers 2 years ago. Now one is 'changing' them
for us. The only way that happens is if they can get in the official
tree. I know just from monitoring this list that our drivers would never
be acceptable for inclusion in any "functional form". We open sourced
them purely out of respect for the way we know the community feels about
it.

It would cost more for us to make them acceptable for inclusion than it
does for us to just maintain them ourselves. I suspect that is true for
most vendor created drivers open source or not.

So kernel developers making the required changes as the kernel changes
is NO real incentive for any vendor to open source their drivers. Sorry.

If it were knowingly less difficult to actually get your drivers
included, that would be an incentive and then you original point would
hold as an additional incentive.

My humble $.02 worth

Regards
Mark



