Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314270AbSD0Pvx>; Sat, 27 Apr 2002 11:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314272AbSD0Pvw>; Sat, 27 Apr 2002 11:51:52 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.98]:18594 "EHLO
	pimout5-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S314270AbSD0Pvv>; Sat, 27 Apr 2002 11:51:51 -0400
Subject: Re: The tainted message
From: Richard Thrapp <rthrapp@sbcglobal.net>
To: Francois Romieu <romieu@cogenit.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020427140830.A32034@fafner.intra.cogenit.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 27 Apr 2002 10:51:52 -0500
Message-Id: <1019922717.8819.62.camel@wizard>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-27 at 07:08, Francois Romieu wrote:
> Richard Thrapp <rthrapp@sbcglobal.net> :
> [...]
> > First of all, the current tainted message is not really useful. 
> > "Warning: Loading %s will taint the kernel..." isn't very informative at
> > all.  Most people don't know what it means to "taint the  kernel".  It's
> 
> Add a reference to http://www.tux.org/lkml/#s1-18. An explanation is already
> there.

That doesn't fix the problem.  The message is still wrong.  A reference
to an explanation only helps the people who can reach it immediately. 
Linux is also used on manufacturing floors (and several other places)
where no network connections exist.

-- Richard Thrapp

