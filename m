Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264776AbTFTVX2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264793AbTFTVX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:23:27 -0400
Received: from adsl-63-192-245-251.dsl.lsan03.pacbell.net ([63.192.245.251]:54281
	"HELO smtphost.connect4less.com") by vger.kernel.org with SMTP
	id S264776AbTFTVW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:22:27 -0400
Subject: Re: make menuconfig error
From: David Christensen <davidc@connect4less.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Michael Buesch <fsdeveloper@yahoo.de>, mec@shout.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200306202308.38124.m.c.p@wolk-project.de>
References: <1056140839.31828.46.camel@pluto.connect4less.com>
	 <200306202300.16113.fsdeveloper@yahoo.de>
	 <200306202308.38124.m.c.p@wolk-project.de>
Content-Type: text/plain
Organization: Connect4Less, Inc.
Message-Id: <1056144983.31828.50.camel@pluto.connect4less.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Jun 2003 14:36:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are correct Marc!  At least that's how I tripped it.

On Fri, 2003-06-20 at 14:08, Marc-Christian Petersen wrote:
> On Friday 20 June 2003 22:59, Michael Buesch wrote:
> 
> Hi,
> 
> > On Friday 20 June 2003 22:27, David Christensen wrote:
> > >  Q> scripts/Menuconfig: line 832: MCmenu73: command not found
> > >
> > >  Please report this to the maintainer <mec@shout.net>.  You may also
> > >  send a problem report to <linux-kernel@vger.kernel.org>.
> > >  Please indicate the kernel version you are trying to configure and
> > >  which menu you were trying to enter when this error occurred.
> > Please do that. :)
> > >  make: *** [menuconfig] Error 1
> I guess this is another^4 bugreport from a Mandrake Kernel where this occurs 
> if you enter the ALSA menu.
> 
> ciao, Marc
> 

