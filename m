Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTKMHGg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 02:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTKMHGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 02:06:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6111 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261892AbTKMHGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 02:06:34 -0500
Date: Thu, 13 Nov 2003 08:06:27 +0100
From: Jens Axboe <axboe@suse.de>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031113070627.GU21141@suse.de>
References: <Pine.LNX.4.44.0311102136280.2881-100000@home.osdl.org> <20031111184919.43a93a88.diegocg@teleline.es> <boudu6$k3j$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <boudu6$k3j$1@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12 2003, bill davidsen wrote:
> In article <20031111184919.43a93a88.diegocg@teleline.es>,
> Diego Calleja =?ISO-8859-15?Q?Garc=EDa?=  <diegocg@teleline.es> wrote:
> | El Mon, 10 Nov 2003 21:40:58 -0800 (PST) Linus Torvalds <torvalds@osdl.org>
> | escribió:
> | 
> | > Now it's your turn. Instead of wasting my time complaining, how about you
> | > put up or shut up? Show me the code. THEN post it. Until you do, there's 
> | > no point to your mails.
> | 
> | Until then, I'd suggest this patch to avoid more complains about this:
> 
> The object is not to avoid complaints, the object is to get the

If it could avoid your non-stop whining...

> capability working again. I presume eventually one of the commercial
> vendors will fix it, since it's easier than rewriting all the SCSI
> applications in the world. oddly there are people writing useful things
> using other operating systems, under 2.4 almost all of those work.

It's not about applications, we can fix that differently. You still
don't seem to get that moving from ide-scsi is a _good_ thing, from the
application point of view. It's about hardware that doesn't work well
with atapi drivers yet, for whatever reason. ide-scsi is nice to have to
fill those holes.

> I hope to pick up another IDE tape drive so I can look at this problem,
> the one I have is on a production system, which at the moment has no
> reason to go to 2.6 even if it worked, which it doesn't. It also has
> software to read ZIP drives in odd ways, and I'm not about to look for a
> SCSI 100MB ZIP drive :-(

Until then please pipe down, your mails are getting pretty tedious. I
dunno why I even read this one.

-- 
Jens Axboe

