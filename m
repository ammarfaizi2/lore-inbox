Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTDQQAX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 12:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbTDQQAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 12:00:22 -0400
Received: from smtp.terra.es ([213.4.129.129]:9091 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S261754AbTDQQAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 12:00:21 -0400
Date: Thu, 17 Apr 2003 18:12:28 +0200
From: Arador <diegocg@teleline.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Debugging hard lockups (hardware?)
Message-Id: <20030417181228.31f95b7f.diegocg@teleline.es>
In-Reply-To: <1049663095.1602.37.camel@dhcp22.swansea.linux.org.uk>
References: <3E8FC9FB.A030ACFB@vtc.edu.hk>
	<1049654048.1600.11.camel@dhcp22.swansea.linux.org.uk>
	<20030406222959.63add445.diegocg@teleline.es>
	<1049663095.1602.37.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Apr 2003 22:04:55 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sul, 2003-04-06 at 21:29, Arador wrote:
> > I've a similar hang; no oops; no sysrq; no NMI messages;
> > But mine only happens under 2.5; since long time ago.
> > The one strange thing is that it seems that it's not hanged;
> > since the X pointer moves in 3-5 seconds intervals (it even
> > change the shape in the window's corners).
> 
> So its not hanging, but acting like something gets burning
> CPU. If you can duplicate this in non X next time it occurs
> use right-alt or shift or ctrl and scrolllock get some data
> on what its doing.

It doesn't work either :( (sorry for the delay, but i use
X quite a lot and took me a while to reproduce it again in console)

The description is above....a hang that happens randomly in 2.5
from ages; both with and without X; no sysrq or NMI messages....
now i checked that right-alt/shift/ctrl and scrolllock doesn't work...
i suspect this might be a hardware failure; i should run it a while under
2.4 to see if i get a similar behaviour....

