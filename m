Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276997AbRJHQVQ>; Mon, 8 Oct 2001 12:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276993AbRJHQVH>; Mon, 8 Oct 2001 12:21:07 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:412 "EHLO mauve.demon.co.uk")
	by vger.kernel.org with ESMTP id <S276981AbRJHQUv>;
	Mon, 8 Oct 2001 12:20:51 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200110081621.RAA19386@mauve.demon.co.uk>
Subject: Re: Odd keyboard related crashes.
To: linux-kernel@vger.kernel.org
Date: Mon, 8 Oct 2001 17:21:11 +0100 (BST)
In-Reply-To: <m1eloew47p.fsf@frodo.biederman.org> from "Eric W. Biederman" at Oct 08, 2001 09:18:02 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Pavel Machek <pavel@suse.cz> writes:
> 
> > Hi!
> > 
> > > >>> Ian Stirling <root@mauve.demon.co.uk> 10/05/01 05:01AM >>>
> > > >I'm running 2.4.10, and the ps/2 keyboard came out of it's socket.

I should possibly have mentioned that APM is enabled on this machine,
but no suspend/standby had been done, it's only for use in power-cuts
when I want to minimise draw from the UPS batteries.
The machine is an athlon desktop.

I'll see if I can reproduce this with 2.4.11, 2.4.10 is utterly unusable
for me. (totally insane swapping out causing things to get killed on 
significant reading.

