Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVF1XEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVF1XEE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVF1XAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:00:20 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:37085 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262203AbVF1W7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:59:32 -0400
Message-ID: <4846.10.10.10.24.1119999568.squirrel@linux1>
In-Reply-To: <20050628224946.GU12006@waste.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
    <20050624064101.GB14292@pasky.ji.cz>
    <20050624123819.GD9519@64m.dyndns.org>
    <20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org>
    <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
    <3886.10.10.10.24.1119991512.squirrel@linux1>
    <20050628221422.GT12006@waste.org>
    <3993.10.10.10.24.1119997389.squirrel@linux1>
    <20050628224946.GU12006@waste.org>
Date: Tue, 28 Jun 2005 18:59:28 -0400 (EDT)
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
From: "Sean" <seanlkml@sympatico.ca>
To: "Matt Mackall" <mpm@selenic.com>
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>, "Petr Baudis" <pasky@ucw.cz>,
       "Christopher Li" <hg@chrisli.org>, "Jeff Garzik" <jgarzik@pobox.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Git Mailing List" <git@vger.kernel.org>, mercurial@selenic.com
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, June 28, 2005 6:49 pm, Matt Mackall said:

> Again, have fun with that. Mercurial already went down this path a
> month ago, discovered it couldn't reasonably be fixed without
> abandoning the hashes as file name scheme, and changed repo layout.
>
> Git's going to have a much harder time as it's pretty solidly tied to
> lookup by contents hash. If you throw that out, you might as well use
> Mercurial.
>

By the sounds of it, git could just use Mecurial or some variation thereof
as a back end.  Git is not tied to it's back end.   Afterall, Mecurial
just took the basic ideas from Linus' and adapted them to a different back
end.  But there are very few situation where Git performance is a
practical problem, and where it is things are being addressed.   Git is
already so much better for the things I do than BK ever was, I'll stick
with it.

Sean.


