Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264876AbTFYRpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264869AbTFYRpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:45:23 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:35806 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264860AbTFYRpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:45:11 -0400
Date: Wed, 25 Jun 2003 19:58:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lou Langholtz <ldl@aros.net>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Anyone for NBD maintainer [was Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl UI]
Message-ID: <20030625175849.GB4988@elf.ucw.cz>
References: <3EF94672.3030201@aros.net> <20030625001950.16bbb688.akpm@digeo.com> <3EF9C192.7000206@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF9C192.7000206@aros.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>That said, this seems like an opportunistic time to further break 
> >>compatibility with the existing nbd-client user tool and  do away with 
> >>the problematic components of the ioctl user interface.
> >>   
> >>
> >Is a suitably modified userspace tool available?

> Here is an updated patch 6 (I called it 6.1) that fixes some additional 
> locking issues as well as fixing the header file so it can be used
> by 

...

BTW Anyone wanting to become nbd maintainer? I'm not much interested
in nbd these days...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
