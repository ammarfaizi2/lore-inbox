Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVGCUz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVGCUz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 16:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVGCUz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 16:55:57 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4881 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261533AbVGCUzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 16:55:16 -0400
Date: Sun, 3 Jul 2005 22:53:31 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
Message-ID: <20050703205331.GA9300@irc.pl>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1119559367.20628.5.camel@mindpipe> <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net> <20050625144736.GB7496@atrey.karlin.mff.cuni.cz> <42BD9EBD.8040203@linuxwireless.org> <20050625200953.GA1591@ucw.cz> <42C7A3B2.4090502@linuxwireless.org> <20050703101613.GA2372@ucw.cz> <9a8748490507030407547fa29b@mail.gmail.com> <42C82BBB.9090008@gmail.com> <1120418514.4351.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120418514.4351.6.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 12:21:54PM -0700, Dave Hansen wrote:
> On Sun, 2005-07-03 at 20:17 +0200, Jesper Juhl wrote:
> > Ok, just to show you people what I've done so far.
> > This doesn't work yet, but it should be resonably close (at least it
> > builds ;)
> 
> On top of what you sent at first this morning (not the most recent one)
> I did some stuff (in the attached patch).  It implements the last bit of
> initialization that your earlier one didn't do, but I see you've done in
> the most recent one.
> 
> Anyway, I get 10 reads out of it, 1 second apart, and it appears to be
> getting real data:

 Could this be done in userspace?


-- 
Tomasz Torcz                Only gods can safely risk perfection,
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia

