Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbTELTZN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTELTZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:25:12 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:47277 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S262572AbTELTZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:25:02 -0400
Date: Tue, 13 May 2003 07:33:46 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [PATCH] restore sysenter MSRs at resume
In-reply-to: <20030512113017.GA25757@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>, mikpe@csd.uu.se,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1052768026.1865.0.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200305101641.h4AGfEVE002970@harpo.it.uu.se>
 <Pine.LNX.4.44.0305111158500.12955-100000@home.transmeta.com>
 <20030511190822.GA1181@atrey.karlin.mff.cuni.cz>
 <1052681292.1869.5.camel@laptop-linux>
 <20030512113017.GA25757@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-12 at 23:30, Pavel Machek wrote:
> Hi!
> 
> > Ok. I haven't updated it for 2.5.69 version, but it doesn't look like
> > any changes are required. Here is the relevant part of the full swsusp
> > patch.
> 
> I guess it still needs to be updated for the driver model....

Yes,

No time here :> I'm busy with my real work and with work on 2.4 swsusp.

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

