Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTGCMOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 08:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbTGCMOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 08:14:11 -0400
Received: from mail.ithnet.com ([217.64.64.8]:32018 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261151AbTGCMOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 08:14:09 -0400
Date: Thu, 3 Jul 2003 14:28:53 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: mason@suse.com, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, andrea@suse.de, piggin@cyberone.com.au
Subject: Re: Status of the IO scheduler fixes for 2.4
Message-Id: <20030703142853.0c5baa63.skraw@ithnet.com>
In-Reply-To: <200307031407.02580.m.c.p@wolk-project.de>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva>
	<1057197726.20903.1011.camel@tiny.suse.com>
	<20030703125828.1347879d.skraw@ithnet.com>
	<200307031407.02580.m.c.p@wolk-project.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jul 2003 14:07:12 +0200
Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:

> On Thursday 03 July 2003 12:58, Stephan von Krawczynski wrote:
> 
> Hi Stephan,
> 
> > I have a short question on that: did you check if there are any drawbacks
> > on network performance through this? We had a phenomenon here with 2.4.21
> > with both samba and simple ftp where network performance dropped to a crawl
> > when simply entering "sync" on the console. Even simple telnet-sessions
> > seemed to be affected. As we could not create a reproducable setup I did
> > not talk about this up to now, but I wonder if anyone else ever checked
> > that out ...
> does the patch from Chris cause this?

No, this is an independent issue. We did not try these patches so far.
The question was purely informative. We did not dig into the subject for lack
of time upto now - just a "try and see if anyone can back our experience".

Regards,
Stephan

