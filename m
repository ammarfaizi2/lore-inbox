Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272754AbTG1JO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 05:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272758AbTG1JO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 05:14:26 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:62635 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272754AbTG1JOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 05:14:25 -0400
Date: Mon, 28 Jul 2003 11:29:22 +0200
From: Pavel Machek <pavel@suse.cz>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, cb-lkml@fish.zetnet.co.uk
Cc: Pavel Machek <pavel@suse.cz>, jimis@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related)
Message-ID: <20030728092922.GB233@elf.ucw.cz>
References: <3F1E6A25.5030308@gmx.net> <20030723114322.GD729@zaurus.ucw.cz> <Pine.LNX.4.55L.0307251723520.16728@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307251723520.16728@freak.distro.conectiva>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > With the current scheduler we can prioritize the CPU usage for each
> > > process. What I think would be extremely useful (as I have needed it
> > > many times) is the scheduling of disk I/O and net I/O traffic. 2
> > > examples showing the importance (the numbers are estimations just to
> > > explain whati I mean):
> >
> > Yes that would be nice, and in 2.5 timeframe
> > there was patch doing that. Port it to 2.6 an test it!
>
> Do you remember who wrote those or where one can find it?

After a bit of searching I found this. I'm not 100% sure this is the
same one I am remembering, but it looks like that.

http://marc.theaimsgroup.com/?l=linux-kernel&m=103962160319984&w=2

[No, I'm probably remembering some other patch, this looks way too
simple, but may be good point to start...]
							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
