Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261870AbSJJRpk>; Thu, 10 Oct 2002 13:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSJJRpk>; Thu, 10 Oct 2002 13:45:40 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:64017 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261870AbSJJRpj>;
	Thu, 10 Oct 2002 13:45:39 -0400
Date: Thu, 10 Oct 2002 19:51:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
Message-ID: <20021010195123.A13678@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0210100035210.338-100000@serv> <3DA58C1E.3090102@pobox.com> <20021010192924.A13618@mars.ravnborg.org> <3DA5B99B.5080707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA5B99B.5080707@pobox.com>; from jgarzik@pobox.com on Thu, Oct 10, 2002 at 01:32:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 01:32:11PM -0400, Jeff Garzik wrote:
> The kernel is written for people with a clue.  For people without a 
> clue, they should use a vendor kernel or ESR's Aunt-Tillie-friendly system.
> 
> Dumbing-down the kernel is never the right answer.

Well I'm not talking about dumbing-down the kernel. What I'm talking about
is to keep existing functionality.
For sure the kernel is made for people with a clue, but still people
with a clue sometimes makes stupid mistakes.

A build system that catches obvious stupid mistakes is IMHO a good thing.
But it shall not that for any cost, and the normal incremental build
shall continue to be as fast as possible.

	Sam
