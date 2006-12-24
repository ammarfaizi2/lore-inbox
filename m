Return-Path: <linux-kernel-owner+w=401wt.eu-S1751347AbWLXNlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWLXNlS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 08:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWLXNlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 08:41:18 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:3168 "EHLO
	BAYC1-PASMTP11.CEZ.ICE" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751347AbWLXNlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 08:41:17 -0500
X-Greylist: delayed 1147 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2006 08:41:17 EST
X-Originating-IP: [69.156.137.239]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Sun, 24 Dec 2006 08:22:07 -0500
From: Sean <seanlkml@sympatico.ca>
To: Mark Hounschell <dmarkh@cfl.rr.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
Message-Id: <20061224082207.dcc0b955.seanlkml@sympatico.ca>
In-Reply-To: <458E6B46.2060201@cfl.rr.com>
References: <20061214003246.GA12162@suse.de>
	<22299.1166057009@lwn.net>
	<20061214005532.GA12790@suse.de>
	<Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
	<45811AA6.1070508@superbug.co.uk>
	<458E6B46.2060201@cfl.rr.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Dec 2006 13:32:40.0781 (UTC) FILETIME=[FC12B7D0:01C7275F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Dec 2006 06:57:58 -0500
Mark Hounschell <dmarkh@cfl.rr.com> wrote:


> Hum. We open sourced our drivers 2 years ago. Now one is 'changing' them
> for us. The only way that happens is if they can get in the official
> tree. I know just from monitoring this list that our drivers would never
> be acceptable for inclusion in any "functional form". We open sourced
> them purely out of respect for the way we know the community feels about
> it.

That shows some class, thanks.

> It would cost more for us to make them acceptable for inclusion than it
> does for us to just maintain them ourselves. I suspect that is true for
> most vendor created drivers open source or not.
> 
> So kernel developers making the required changes as the kernel changes
> is NO real incentive for any vendor to open source their drivers. Sorry.
> 
> If it were knowingly less difficult to actually get your drivers
> included, that would be an incentive and then you original point would
> hold as an additional incentive.

Out of curiosity what specific technical issues in your driver code make
you think that it would be too expensive to whip them into shape for
inclusion?

Cheers,
Sean

