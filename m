Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262488AbTCMRoY>; Thu, 13 Mar 2003 12:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbTCMRoY>; Thu, 13 Mar 2003 12:44:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53913 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262488AbTCMRoX>;
	Thu, 13 Mar 2003 12:44:23 -0500
Date: Thu, 13 Mar 2003 18:54:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64-mm6: kernel BUG at kernel/timer.c:155!
Message-ID: <20030313175454.GP836@suse.de>
References: <1047576167.1318.4.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047576167.1318.4.camel@ixodes.goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13 2003, Jeremy Fitzhardinge wrote:
> I was reading back a freshly burned CD from my shiny new Plexwriter
> 48/24/48A.  I'm using ide-scsi, so this is an iso9660 filesystem mounted

out of curiousity, why? ide-cd should work much better than ide-scsi in
2.5, if it doesn't I'd like to know.

yes, the ide-scsi bug should be fixed too, of course... but I cannot
care too much about that in 2.5, should mainly be a non-cd/dvd atapi
host.

-- 
Jens Axboe

