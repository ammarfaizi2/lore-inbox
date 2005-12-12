Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVLLRfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVLLRfF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 12:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVLLRfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 12:35:05 -0500
Received: from lizards-lair.paranoiacs.org ([216.158.28.252]:16345 "EHLO
	lizards-lair.paranoiacs.org") by vger.kernel.org with ESMTP
	id S932073AbVLLRfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 12:35:03 -0500
Date: Mon, 12 Dec 2005 12:34:56 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Rob Landley <rob@landley.net>
Cc: Pavel Machek <pavel@ucw.cz>, Bill Davidsen <davidsen@tmr.com>,
       Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: ipw2200 [was Re: RFC: Starting a stable kernel series off the 2.6 kernel]
Message-ID: <20051212173456.GB8209@paranoiacs.org>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	Pavel Machek <pavel@ucw.cz>, Bill Davidsen <davidsen@tmr.com>,
	Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
	David Ranson <david@unsolicited.net>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Matthias Andree <matthias.andree@gmx.de>
References: <20051203135608.GJ31395@stusta.de> <200512071214.26574.rob@landley.net> <20051210083503.GA2833@ucw.cz> <200512102330.31572.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512102330.31572.rob@landley.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2005 23:30:30 -0600, Rob Landley wrote:
> Query: if you tell lilo or grub that it has an initrd but feed it a gzipped 
> cpio image, will the kernel figure everything out and initialize initramfs 
> from that appropriately?

Yes, I've been booting my laptop this way (using GRUB) since 2.6.7 or so.

-- 
Ben Slusky                  | It was only after their population
sluskyb@paranoiacs.org      | of 50 mysteriously shrank to eight
sluskyb@stwing.org          | that the other seven dwarfs began
PGP keyID ADA44B3B          | to suspect Hungry.
