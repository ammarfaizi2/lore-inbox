Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933840AbWKWQEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933840AbWKWQEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933846AbWKWQEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:04:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44818 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S933840AbWKWQEE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:04:04 -0500
Date: Tue, 21 Nov 2006 20:51:24 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Schmid <chris@schlagmichtod.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
Message-ID: <20061121205124.GB4199@ucw.cz>
References: <455DAF74.1050203@schlagmichtod.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455DAF74.1050203@schlagmichtod.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Well, the actual question is the following,
> I read about HDAPS on thinkWiki. But there is no known-to-work patch for
> 2.6.18 and above to enable queue-freezing/harddisk parking.
> After some googeling and digging in gamne i read that someone said that
> there are plans for some generic support for HD-parking in the kernel
> and thus making such patches obsolete.
> My quesiotn just is if this is true and if there are any chances that
> the kernel will support that soonly.
...
> So i hope this issue can be adressed soon. but i also know that most of
> you are very busy and i can not evaluate how difficult such a change
> would be. However if anyone wants to test some things or more
> information, i am ready. Just CC me :)

I'm afraid we need your help with development here. Porting old patch
to 2.6.19-rc6 should be easy, and then you can start 'how do I
makethis generic' debate.

Does hdaps work for you, btw? It gave all zeros on my x60, iirc.
-- 
Thanks for all the (sleeping) penguins.
