Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVCPRJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVCPRJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVCPRJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:09:52 -0500
Received: from orb.pobox.com ([207.8.226.5]:4245 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262687AbVCPRJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:09:51 -0500
Date: Wed, 16 Mar 2005 11:09:45 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, rusty@rustcorp.com.au
Subject: Re: CPU hotplug on i386
Message-ID: <20050316170945.GK21853@otto>
References: <20050316132151.GA2227@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316132151.GA2227@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 02:21:52PM +0100, Pavel Machek wrote:
> Hi!
> 
> I tried to solve long-standing uglyness in swsusp cmp code by calling
> cpu hotplug... only to find out that CONFIG_CPU_HOTPLUG is not
> available on i386. Is there way to enable CPU_HOTPLUG on i386?

i386 cpu hotplug has been in -mm for a while.  Don't know when (if
ever) it will get merged.

Nathan
