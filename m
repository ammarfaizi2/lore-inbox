Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbTI2TZO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264555AbTI2TZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:25:13 -0400
Received: from gprs144-48.eurotel.cz ([160.218.144.48]:31619 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264553AbTI2TZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:25:09 -0400
Date: Mon, 29 Sep 2003 21:24:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pm: Revert swsusp to 2.6.0-test3
Message-ID: <20030929192458.GA1825@elf.ucw.cz>
References: <20030928175853.GF359@elf.ucw.cz> <Pine.LNX.4.44.0309290902150.968-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309290902150.968-100000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ok. In that case, can we remove the '#if 0' blocks entirely, or at least 
> > > add a big comment on why they are there but disabled?
> > 
> > Like this?
> 
> Pavel, I don't even know where to begin, but I will suggest that you check 
> your sources better. I did apply the patch to revert swsusp to the state 
> it was in -test3. According to bitkeeper, it's ChangeSet 1.1217.3.31, 
> which can be viewed here: 

I'm sorry, I did update on bkcvs and could not find patch. Probably I
screwed up when dealing with bkcvs.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
