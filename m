Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWGHLNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWGHLNe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWGHLNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:13:33 -0400
Received: from beauty.rexursive.com ([203.171.74.242]:53671 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S964785AbWGHLNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:13:15 -0400
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp /
	suspend2 reliability]
From: Bojan Smojver <bojan@rexursive.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       jan@rychter.com, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>
In-Reply-To: <200607081238.16753.rjw@sisk.pl>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <20060708002826.GD1700@elf.ucw.cz>
	 <200607081342.40686.ncunningham@linuxmail.org>
	 <200607081238.16753.rjw@sisk.pl>
Content-Type: text/plain
Organization: Rexursive
Date: Sat, 08 Jul 2006 21:13:12 +1000
Message-Id: <1152357192.2088.6.camel@beast.rexursive.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 12:38 +0200, Rafael J. Wysocki wrote:

> Actually, as I said above, as soon as we are _sure_ that LRU pages are not
> touched after the memory has been snapshotted, my patch will be mergeable
> and we'll get the ability to create bigger images without the added
> complexity.  [Apart from the fact that the whole memory image on a box with
> more that 512 MB of RAM wouldn't make much sense, IMHO.]  The _only_ thing
> needed here is an argument which you have to provide anyway to show that
> suspend2 does the right thing.
> 
> As far as the support for ordinary files, swap files, etc. is concerned,
> there's nothing to worry about.  It's comming.

This all sounds very encouraging. What's the rough timeframe for this?

-- 
Bojan

