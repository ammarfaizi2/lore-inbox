Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTE1XBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTE1XBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:01:42 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:65525 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S261562AbTE1XBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:01:40 -0400
Date: Thu, 29 May 2003 11:19:49 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [PATCH] fix oops on resume from apm bios initiated suspend
In-reply-to: <20030528230534.GC2236@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@digeo.com>, mikpe@csd.uu.se, miltonm@bga.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Message-id: <1054163988.28296.1.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200305280643.h4S6hRQF028038@sullivan.realtime.net>
 <20030528111401.GB342@elf.ucw.cz>
 <16084.46712.707240.943086@gargle.gargle.HOWL>
 <20030528152827.5387e033.akpm@digeo.com> <20030528230534.GC2236@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-29 at 11:05, Pavel Machek wrote:
> Yes, we want system to be similar state it was when we suspended, to
> prevent heisenbugs.

Heisenbugs? What's that in English? Sounds like it might be house bugs!

Regards,

Nigel

