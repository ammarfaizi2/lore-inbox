Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270393AbTGMUzg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270394AbTGMUzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:55:36 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:26501 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270393AbTGMUzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:55:36 -0400
Date: Sun, 13 Jul 2003 23:09:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030713210934.GK570@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net> <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk> <20030713193114.GD570@elf.ucw.cz> <1058130071.1829.2.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058130071.1829.2.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Escape is more intuitively obvious though - I would expect the suspend
> button to only start a suspend. And the idea of escape cancelling
> anything is well in-grained in peoples' minds.

You did not initiate suspend from keyboard => you should not
terminate it from keyboard.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
