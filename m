Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264513AbRFOUW3>; Fri, 15 Jun 2001 16:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264516AbRFOUWT>; Fri, 15 Jun 2001 16:22:19 -0400
Received: from devco.net ([196.15.188.2]:42882 "EHLO rinoa")
	by vger.kernel.org with ESMTP id <S264514AbRFOUWP>;
	Fri, 15 Jun 2001 16:22:15 -0400
Date: Fri, 15 Jun 2001 22:22:14 +0200
From: Leon Breedt <ljb@devco.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] nonblinking VGA block cursor
Message-ID: <20010615222214.A3772@rinoa.prv.dev.itouchnet.net>
In-Reply-To: <20010615162249.A1328@rinoa.rinoa> <200106151921.f5FJLsc03635@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106151921.f5FJLsc03635@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Fri, Jun 15, 2001 at 03:21:54PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001 at 03:21:54PM -0400, Albert D. Cahalan wrote:

> Non-blinking cursors are just wrong. You need to patch your brain.
> You really fucked up, because now apps can't restore your cursor
> to proper behavior as defined by IBM.
I don't want them to, because I prefer non-blinking. It feels more
solid, kind of like driving a tank instead of a little dune buggy ;)

> The blinking cursor is implemented in your video hardware.
> IBM knew what was right for you. 
Uh, said hardware lets you disable the blinking. Maybe in a slightly
non-standard way, who cares?

> Of course FreeBSD has a block cursor. It was easy to program,
> and it seems nice to the pot-smoking hippies out in Berkeley.
> FreeBSD doesn't define standards. FreeBSD breaks standards.
> (zombie creation, "ps -ef", partition tables, pty allocation...)
It's all about choice, man. I want the choice to have certain
behaviour if I wish.

-- 
lj breedt
coder
