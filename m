Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVAYA6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVAYA6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVAYA5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:57:01 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26011 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261729AbVAYAxh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:53:37 -0500
Subject: Re: DVD burning still have problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Jens Axboe <axboe@suse.de>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1106607691.13336.10.camel@localhost>
References: <200501232126.55191.volker.armin.hemmann@tu-clausthal.de>
	 <5a4c581d050123125967a65cd7@mail.gmail.com> <20050124150755.GH2707@suse.de>
	 <1106594023.6154.89.camel@localhost.localdomain>
	 <20050124204529.GA19242@suse.de>
	 <1106598811.6154.93.camel@localhost.localdomain>
	 <1106607691.13336.10.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106610498.10239.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 Jan 2005 23:48:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-24 at 23:01, Kasper Sandberg wrote:
> > there are certainly chipset and CPU errata in this area.
> would this mean that i should not use cpu frequency scaling?

Worth an experiment but I'd be suprised if it was your fix. The more
data the better however 

