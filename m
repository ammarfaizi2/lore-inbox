Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTH3Ppk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 11:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbTH3Ppk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 11:45:40 -0400
Received: from imap.gmx.net ([213.165.64.20]:51081 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261878AbTH3Ppj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 11:45:39 -0400
Date: Sat, 30 Aug 2003 21:15:47 +0530
From: Apurva Mehta <apurva@gmx.net>
To: Rahul Karnik <rahul@genebrew.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O19int
Message-ID: <20030830154547.GA1299@home.woodlands>
Mail-Followup-To: Rahul Karnik <rahul@genebrew.com>,
	Con Kolivas <kernel@kolivas.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200308291550.28159.kernel@kolivas.org> <20030829153137.GB1765@home.woodlands> <3F4F7F73.9080909@genebrew.com> <20030829164137.GC1765@home.woodlands> <3F4F908A.5000204@genebrew.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4F908A.5000204@genebrew.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rahul Karnik <rahul@genebrew.com> [30-08-2003 20:46]:
> Somehow I can never reproduce these xmms skips, even in mainline 
> kernels. I had them for a few days with older versions of rhythmbox, but 
> no longer. So it seems that some of this is definitely system dependent? 
> For the record, I have an Athlon XP 2100+ (1700 MHz) and 1G of memory (a 
> pretty medium line desktop system), not the multi-cpu multi-gigabyte-RAM 
> systems some people around here do.
> 
> Are people getting skips on hardware that is faster than this?

Well, I have a 500 Mhz PIII and 192 MB of RAM. However, I never ever
get skips with stock 2.4 or with O11int. 

Also, I noticed today that while the system was under moderate load
(~100 procmail/sendmail pairs filtering mail through spamassassin +
Firebird + xmms), starting an app like emacs took ages. I had to wait
and wait and finally only when I tried to open a second instance did
the first one come up. That did not happen before..

	- Apurva
