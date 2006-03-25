Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWCYFtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWCYFtF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 00:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWCYFtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 00:49:04 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:44450 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751057AbWCYFtC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 00:49:02 -0500
Message-ID: <4424D9CA.7090303@drzeus.cx>
Date: Sat, 25 Mar 2006 06:48:58 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, Mark Lord <lkml@rtr.ca>,
       "David J. Wallace" <katana@onetel.com>, sdhci-devel@list.drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [Sdhci-devel] Submission to the kernel?
References: <4419FA7A.4050104@cogweb.net> <200603171042.52589.katana@onetel.com> <441AD537.5080403@rtr.ca> <441AD9C3.2090703@drzeus.cx> <20060317170126.GB32281@kroah.com> <441AEEBB.10104@drzeus.cx> <20060325023942.GC6416@kroah.com>
In-Reply-To: <20060325023942.GC6416@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Tried it out and it works great (also see it's in 2.6.16-git9 now).  Hm,
> my laptop's slot also supports xD cards, which your patch set does not
> yet support, right?
>
>   

And will never do. Different hardware, interface and protocol.

Rgds
Pierre

