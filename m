Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTEIJy3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 05:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTEIJy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 05:54:29 -0400
Received: from mail.ithnet.com ([217.64.64.8]:42762 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S262424AbTEIJy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 05:54:28 -0400
Date: Fri, 9 May 2003 12:06:48 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-Id: <20030509120648.1e0af0c8.skraw@ithnet.com>
In-Reply-To: <2804790000.1052441142@aslan.scsiguy.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 May 2003 18:45:42 -0600
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> > Hi,
> > [...]
> > Justin, unfortunately I can't even THINK about updating aic7xxx to your
> > new driver at the current release stage. I will do so in the 2.4.22.
> 
> [...]
> Again, if you have concerns about the aic7xxx or aic79xx drivers, my
> mail box is always open.  Waiting to contact me until the last minute
> where I can only sit on the sidelines and watch another train wreck is
> not the best way to ensure that the drivers function correctly in 2.4.X.
> 
> What this basically boils down to is trust.  If you don't trust me,
> tell me how I can build that trust.  Without it, I can only continue
> to tell most people that contact me with bug reports, "It's already
> fixed in the official driver.  You can pull the latest from ..."

Justin, just to complete the picture: as I wrote some days ago concerning your
hint to "use the latest from ..." your latest driver does not complete booting
on (at least) my system but freezes - which I wrote to LKML. I have not yet
heard
anything about this issue. You cannot expect to include a newer driver which
performs obviously worse in some cases.
"Worse" here means "fails" and not "performs bad". Marcelos' decision on the
topic looks pretty reasonable to me...

Regards,
Stephan

