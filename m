Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbSJAKXa>; Tue, 1 Oct 2002 06:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSJAKXa>; Tue, 1 Oct 2002 06:23:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26241 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261572AbSJAKX3>;
	Tue, 1 Oct 2002 06:23:29 -0400
Date: Tue, 1 Oct 2002 12:28:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
Message-ID: <20021001102846.GN3867@suse.de>
References: <anbkud$q5e$1@penguin.transmeta.com> <Pine.LNX.4.44.0210010318090.1429-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210010318090.1429-100000@dad.molina>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01 2002, Thomas Molina wrote:
> On Tue, 1 Oct 2002, Linus Torvalds wrote:
> 
> > But from what we've seen lately, there really aren't reports of
> > corrupted disks or anything like that that I've seen.  Which is
> > obviously not to say that it couldn't happen, but it's not a very likely
> > occurrence. 
> 
> I'll echo what Linus says, FWIW.  I'm carrying several ide-related 
> problems on my problem report status page 
> (http://members.cox.net/tmolina/kernprobs/status.html)

broken floppy driver
	should be fixed in 2.5.40

ide double init
	fixed (2.5.39, I think)

oops in ide_toggle_bounce
	fixed in 2.5.40


-- 
Jens Axboe

