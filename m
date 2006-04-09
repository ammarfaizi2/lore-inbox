Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWDIXkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWDIXkB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 19:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWDIXkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 19:40:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750721AbWDIXkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 19:40:00 -0400
Date: Sun, 9 Apr 2006 15:39:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: zippel@linux-m68k.org, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/19] kconfig: recenter menuconfig
Message-Id: <20060409153914.3fb468d3.akpm@osdl.org>
In-Reply-To: <200604100932.00701.ncunningham@cyclades.com>
References: <Pine.LNX.4.64.0604091726550.23116@scrub.home>
	<20060409215520.GD30208@mars.ravnborg.org>
	<Pine.LNX.4.64.0604100001220.32445@scrub.home>
	<200604100932.00701.ncunningham@cyclades.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> wrote:
>
> Hi.
> 
> On Monday 10 April 2006 08:10, Roman Zippel wrote:
> > Hi,
> >
> > On Sun, 9 Apr 2006, Sam Ravnborg wrote:
> > > > Further there is now a mix of left aligned and centered output,
> > > > which is ugly
> > >
> > > So we should fix the rest too instead of reintroducing the old
> > > behaviour.
> >
> > Well, I prefer the old behaviour.
> 
> I don't know if you want 2c worth from other people, but I liked menuconfig 
> much better when it was more centred. This new 
> 'everything-hard-against-the-left-margin' look is ugly, IMHO :)
> 

It hardly seems to matter, given that the colours we use make the text
invisible anyway..

