Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTAWHOt>; Thu, 23 Jan 2003 02:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbTAWHOt>; Thu, 23 Jan 2003 02:14:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:49560 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264938AbTAWHOs>;
	Thu, 23 Jan 2003 02:14:48 -0500
Date: Wed, 22 Jan 2003 23:24:07 -0800
From: Andrew Morton <akpm@digeo.com>
To: Kevin Lawton <kevinlawton2001@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please
 consider)
Message-Id: <20030122232407.0ac4fe85.akpm@digeo.com>
In-Reply-To: <20030123070007.8790.qmail@web80310.mail.yahoo.com>
References: <Pine.LNX.4.44.0301222345110.21255-100000@chaos.physics.uiowa.edu>
	<20030123070007.8790.qmail@web80310.mail.yahoo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jan 2003 07:23:51.0671 (UTC) FILETIME=[60F84070:01C2C2B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Lawton <kevinlawton2001@yahoo.com> wrote:
>
> --- Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
> 
> > Three minor points:
> 
> OK, done.  Here's my #3 submission.

Kinda cruel making you do all this work when Linus is unlikely to take the
patch anyway ;)

Thanks for the explanation - all is much clearer - it looks like very cool
technology.

- <asm/if.h> doesn't mean much to me.  Network interface, if anything.  How
  about <asm/asm-macros.h> ?

- It's quite conceivable that the infrastructure will be used for other
  forms of asm-mangling.  Those "Q2" things hurt like hell.  Is there no
  other way?

- application/octet-stream!


