Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262775AbTCQHyi>; Mon, 17 Mar 2003 02:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbTCQHyi>; Mon, 17 Mar 2003 02:54:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57568 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262775AbTCQHyh>;
	Mon, 17 Mar 2003 02:54:37 -0500
Date: Mon, 17 Mar 2003 09:05:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.64-mm6: oops in elv_remove_request
Message-ID: <20030317080522.GE791@suse.de>
References: <20030313190247.GQ836@suse.de> <1047633884.1147.3.camel@ixodes.goop.org> <20030314104219.GA791@suse.de> <1047637870.1147.27.camel@ixodes.goop.org> <20030314113732.GC791@suse.de> <1047664774.25536.47.camel@ixodes.goop.org> <20030314180716.GZ791@suse.de> <1047680345.1508.2.camel@ixodes.goop.org> <20030315081558.GK791@suse.de> <1047783292.1209.3.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047783292.1209.3.camel@ixodes.goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15 2003, Jeremy Fitzhardinge wrote:
> On Sat, 2003-03-15 at 00:15, Jens Axboe wrote:
> > I can reliably crash the box with SG_IO -> ide-cd here, so I'm hoping
> > there's a connection. Need to move it to a box where nmi watchdog
> > actually works...
> 
> And wouldn't you know it - with -mm7 it seems to be working fine...
                                       ^^
What is 'it'?

-- 
Jens Axboe

