Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTKFP2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 10:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTKFP2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 10:28:19 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:4313 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263647AbTKFP2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 10:28:17 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Nico Schottelius <nico-mutt@schottelius.org>
Subject: Re: ide-scsi question: 2x
Date: Thu, 6 Nov 2003 16:33:16 +0100
User-Agent: KMail/1.5.4
Cc: gadio@netvision.net.il, linux-kernel@vger.kernel.org
References: <20031106115813.GF25124@schottelius.org> <200311061558.40845.bzolnier@elka.pw.edu.pl> <20031106150733.GI25124@schottelius.org>
In-Reply-To: <20031106150733.GI25124@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311061633.16770.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 06 of November 2003 16:07, Nico Schottelius wrote:
> > > 2. is the command line hdx=ide-scsi still necessary?
> >
> > Yes, IMO "hdx=driver_name" should be removed instead.
>
> I rechecked this: It is not necessary anymore.

So how do you put drive to scsi emulation if you don't use procfs?

> > >    -> if yes, we should update the help
> >
> > Dunno.
>
> If I update the helpfile, who takes the patch?

Me if it is okay.

--bartlomiej

