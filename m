Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTJaLZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 06:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTJaLZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 06:25:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55762 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263235AbTJaLZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 06:25:47 -0500
Date: Fri, 31 Oct 2003 12:25:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: Swsusp-2.0-2.6-alpha1 [warning: eats disks with	loop!]
Message-ID: <20031031112545.GC23947@atrey.karlin.mff.cuni.cz>
References: <1067064107.1974.44.camel@laptop-linux> <20031025204940.GB276@elf.ucw.cz> <1067153848.13594.49.camel@laptop-linux> <20031026092551.GB293@elf.ucw.cz> <1067163344.13594.170.camel@laptop-linux> <20031030080430.GB198@elf.ucw.cz> <1067542303.4041.9.camel@laptop-linux> <20031031025849.GA21818@atrey.karlin.mff.cuni.cz> <1067575098.16620.4.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067575098.16620.4.camel@laptop-linux>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi!

> I see if I can reproduce and fix the issue. Was the only unusual
> thing
> the loop filesystem? I assume it was mounted rw.

It was pretty standard config otherwise (my notebook). Loops was
mounted rw, and in use.

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
