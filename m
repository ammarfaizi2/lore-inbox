Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUFFUFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUFFUFw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 16:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUFFUFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 16:05:52 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:39866 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264098AbUFFUFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 16:05:48 -0400
Date: Sun, 6 Jun 2004 15:20:12 -0400
From: Ben Collins <bcollins@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux1394-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: firewire problems with suspend
Message-ID: <20040606192012.GB9278@phunnypharm.org>
References: <20040606180925.GA4542@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040606180925.GA4542@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 08:09:25PM +0200, Pavel Machek wrote:
> Hi!
> 
> There are some bad problems with firewire & swsusp. This fixes some,
> but other remain. If ohci1394 is removed before suspend, then
> reinserted, then rmmod hangs.
> 
> This is certainly better better than what was there, what about
> applying?

Applied, thanks.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
