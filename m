Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270834AbTGNU1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270791AbTGNUZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:25:47 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:32153 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270788AbTGNUYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:24:22 -0400
Date: Mon, 14 Jul 2003 22:38:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030714203842.GI902@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net> <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk> <20030713193114.GD570@elf.ucw.cz> <20030714201056.GB24964@ucw.cz> <1058214085.3986.4.camel@laptop-linux> <20030714202947.GH902@elf.ucw.cz> <1058214747.3987.17.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058214747.3987.17.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Fine by me. The whole point is to make debugging easier, not to bloat
> the kernel. It would probably make sense to keep a debugging patch that
> could be used to reinsert the code if a tricky problem arose, but that's
> a long way off now, so not worth stressing about yet.

Agreed, patch that adds debugging is definitely going to be usefull.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
