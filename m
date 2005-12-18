Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbVLRRpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbVLRRpV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 12:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbVLRRpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 12:45:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8616 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965230AbVLRRpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 12:45:20 -0500
Date: Sun, 18 Dec 2005 18:44:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stefan Seyfried <seife@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] swsusp: brainstorming on a freaked-out approach (was: Re: [RFC/RFT] swsusp: image size tunable)
Message-ID: <20051218174453.GA9679@elf.ucw.cz>
References: <200512162209.53128.rjw@sisk.pl> <20051217164726.GA12021@hermes.uziel.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217164726.GA12021@hermes.uziel.local>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, so much for "quick" brainstorming on the issue... Don't bother
> flaming me for any misunderstanding or misconception : )

That's empty reply for you, then.
								Pavel
[mm layer already discards most usefull pages last, so Rafael's
patches do the right thing]
-- 
Thanks, Sharp!
