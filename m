Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSKIA4A>; Fri, 8 Nov 2002 19:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263571AbSKIA4A>; Fri, 8 Nov 2002 19:56:00 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:47366 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263544AbSKIAz7>; Fri, 8 Nov 2002 19:55:59 -0500
Date: Sat, 9 Nov 2002 01:02:40 +0000 (GMT)
From: James Simmons <jsimmons@phoenix.infradead.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: [BK console] console updates.
In-Reply-To: <20021101211153.GA171@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0211090101550.14371-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >    Along with the new fbdev api I also have rewritten the console layer.
> > The goals are:
> 
> Current 2.5.45 (and previous 2.5's) has funny problems on my vesafb
> machines [like half of letters appearing during emacs session, to the
> point you do ^L to repaint]. I hope this fixes it....

It will. I'm waiting for the latest patches whcih do fix all those 
problems. As soon as I get them I will post a updated patch for the fbdev 
changes. 

