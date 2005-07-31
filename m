Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVGaInA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVGaInA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 04:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVGaInA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 04:43:00 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:61580 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261619AbVGaIm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 04:42:56 -0400
Date: Sun, 31 Jul 2005 10:45:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFD] kconfig - introduce cond-source
Message-ID: <20050731084510.GB8588@mars.ravnborg.org>
References: <20050730220100.GA3240@mars.ravnborg.org> <Pine.LNX.4.61.0507310247410.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507310247410.3728@scrub.home>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 02:50:03AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Sun, 31 Jul 2005, Sam Ravnborg wrote:
> 
> > In a couple of cases I have had the need to include a Kconfig file only
> > if present.
> > The current 'source' directive works as one would expect. It bails out
> > if the file is missing.
> 
> I don't really like it, it's an open invitation to abuse.
> I'd rather like to see the user first, which might need it.
Understood.
I will save this until I have a very good example where I need it.

	Sam
