Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbTFYTFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbTFYTFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:05:36 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:31134 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264928AbTFYTFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:05:35 -0400
Date: Wed, 25 Jun 2003 20:30:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lou Langholtz <ldl@aros.net>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Anyone for NBD maintainer [was Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl UI]
Message-ID: <20030625183045.GD4988@elf.ucw.cz>
References: <3EF94672.3030201@aros.net> <20030625001950.16bbb688.akpm@digeo.com> <3EF9C192.7000206@aros.net> <20030625175849.GB4988@elf.ucw.cz> <3EF9E83C.6030504@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF9E83C.6030504@aros.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >BTW Anyone wanting to become nbd maintainer? I'm not much interested
> >in nbd these days...
> >								Pavel
> > 
> >
> I'd be honoured too but not sure what exactly that entails. What other 
> stuff would I have to do besides actively developing it? I won't be able 
> to do anything on the Internet till Monday either.

Well, maintainer gets patches from people and should decide which are
good and which are not...

Anyway if you give me your sf.net name, I can probably add you as a
developer to the nbd.sf.net... but: I'd like you to keep userland code
backward compatible. Ie. new userland code should still work with
2.4.x kernel.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
