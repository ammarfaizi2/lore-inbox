Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbTE3NVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 09:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTE3NVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 09:21:38 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:60582
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263643AbTE3NVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 09:21:37 -0400
Date: Fri, 30 May 2003 09:34:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, m.c.p@wolk-project.de, willy@w.ods.org,
       gibbs@scsiguy.com, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-ID: <20030530133456.GA22969@gtf.org>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <20030524111608.GA4599@alpha.home.local> <20030525125811.68430bda.skraw@ithnet.com> <200305251447.34027.m.c.p@wolk-project.de> <20030526170058.105f0b9f.skraw@ithnet.com> <20030526164404.GA11381@alpha.home.local> <20030530100900.768ceeef.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030530100900.768ceeef.skraw@ithnet.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 10:09:00AM +0200, Stephan von Krawczynski wrote:
> Hello Marcelo,
> 
> I tried plain rc6 now and have to tell you it does not survive a single day of
> my usual tests. It freezes during tar from 3ware-driven IDE to aic-driven SDLT.
> This is identical to all previous rc (and some pre) releases of 2.4.21. So far
> I can tell you that the only thing that has recently cured this problem is
> replacing the aic-driver with latest of justins' releases.

So Justin's driver fixes your 3ware problems???

And exactly what -rc/-pre release stopped working for you?

	Jeff



