Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbVKUAji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVKUAji (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVKUAjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:39:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60289 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750890AbVKUAjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:39:14 -0500
Date: Sun, 20 Nov 2005 21:38:47 +0000
From: Pavel Machek <pavel@suse.cz>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, scjody@steamballoon.com
Subject: Re: [patch 1/3] Add SCM info to MAINTAINERS
Message-ID: <20051120213846.GB2556@spitz.ucw.cz>
References: <20051118173930.270902000@press.kroah.org> <20051118173106.GB20860@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118173106.GB20860@kroah.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Jody McIntyre <scjody@steamballoon.com>
> 
> Add tree information to MAINTAINERS file.
> 
> Signed-off-by: Jody McIntyre <scjody@steamballoon.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  MAINTAINERS |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> --- usb-2.6.orig/MAINTAINERS
> +++ usb-2.6/MAINTAINERS
> @@ -58,6 +58,7 @@ P: Person
>  M: Mail patches to
>  L: Mailing list that is relevant to this area
>  W: Web-page with status/info
> +T: SCM tree type and URL.  Type is one of: git, hg, quilt.
>  S: Status, one of the following:

You are not actually putting urls there. url is git://kernel.org/...

> @@ -183,6 +184,7 @@ P:	Len Brown
>  M:	len.brown@intel.com
>  L:	acpi-devel@lists.sourceforge.net
>  W:	http://acpi.sourceforge.net/
> +T:	git kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
>  S:	Maintained
>  
>  AD1816 SOUND DRIVER
							Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

