Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271425AbUJVQvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271425AbUJVQvA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271435AbUJVQvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:51:00 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:22884 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S271425AbUJVQsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:48:40 -0400
From: tabris <tabris@tabris.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: DVD/ide-cd related Oops 2.6.[89]-mm
Date: Fri, 22 Oct 2004 11:35:31 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>
References: <20041022090145.GA6408@tabriel.tabris.net> <58cb370e04102207351d79c481@mail.gmail.com>
In-Reply-To: <58cb370e04102207351d79c481@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410221135.31315.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 October 2004 10:35 am, Bartlomiej Zolnierkiewicz wrote:
> On Fri, 22 Oct 2004 05:01:45 -0400, Tabris <tabris@tabris.net> wrote:
> >         undecoded slave fixup is a oneliner patch in ide-probe to
> > recognize both of my Maxtor drives that appear to have the same
> > serial number, D3000000. This fix was discussed a month ago or so,
> > as I had run into it, but nothing official came of it, and it was
> > never merged to -mm.
>
> Did you test it on different controller (as asked by Eric)?
	Hmm. no, I had not tried that. I can probably arrange it assuming I end 
up doing any work on the DVD oops as well. Just trying to minimize 
downtime on this system.
>
> > Patch attached.
>
> thanks, I'll apply it
>
> Bartlomiej

--
tabris
-
What, after all, is a halo?  It's only one more thing to keep clean.
		-- Christopher Fry
