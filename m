Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTIFVhW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 17:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTIFVhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 17:37:22 -0400
Received: from [195.39.17.254] ([195.39.17.254]:65409 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261692AbTIFVhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 17:37:21 -0400
Date: Fri, 5 Sep 2003 23:24:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: nagendra_tomar@adaptec.com, Jamie Lokier <jamie@shareable.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030905212420.GD220@elf.ucw.cz>
References: <Pine.LNX.4.44.0309032134040.25093-100000@localhost.localdomain> <1062674382.21667.32.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062674382.21667.32.camel@dhcp23.swansea.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In x86 store buffer is not snooped which leads to all these serialization 
> > issues (other CPUs looking at stale value of data which is in the store 
> > buffer of some other CPU).
> 
> x86 gives you coherency and store ordering (barring errata and special
> CPU modes)

Special CPU modes? You mean some special SSE stores?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
