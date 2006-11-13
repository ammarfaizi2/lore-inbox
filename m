Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755361AbWKMWBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361AbWKMWBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755363AbWKMWBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:01:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23184 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1755361AbWKMWBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:01:39 -0500
Date: Mon, 13 Nov 2006 23:01:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Andi Kleen <ak@suse.de>,
       John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com
Subject: Re: AHCI power saving (was Re: Ten hours on X60s)
Message-ID: <20061113220127.GA1704@elf.ucw.cz>
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz> <45589008.1080001@garzik.org> <200611131637.56737.ak@suse.de> <455893E5.4010001@garzik.org> <4558B232.8080600@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4558B232.8080600@rtr.ca>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-11-13 12:58:10, Mark Lord wrote:
> Jeff Garzik wrote:
> >Andi Kleen wrote:
> >
> >>How does it shorten its life?
> >
> >Parks your hard drive heads many thousands of times more often than it 
> >does without the aggressive PM features.
> 
> Spinning-down would definitely shorten the drive lifespan.  Does it do that?

Not on my machine.

> Parking heads is more like just doing some extra (long) seeks.
> Is this documented somewhere as being a life-shortening action?

I do not see any effects after applying that patch.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
