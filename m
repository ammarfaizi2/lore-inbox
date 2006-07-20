Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWGTGQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWGTGQN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 02:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWGTGQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 02:16:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60422 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030278AbWGTGQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 02:16:12 -0400
Date: Thu, 20 Jul 2006 08:16:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 31/33] Add Xen subarch reboot support
Message-ID: <20060720061611.GB25367@stusta.de>
References: <20060718091807.467468000@sous-sol.org> <20060718091958.119562000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060718091958.119562000@sous-sol.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2006 at 12:00:31AM -0700, Chris Wright wrote:
>...
> --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
> +++ b/drivers/xen/core/reboot.c	Thu Jul 13 18:50:17 2006 -0700
>...
> +EXPORT_SYMBOL(machine_restart);
> +EXPORT_SYMBOL(machine_halt);
> +EXPORT_SYMBOL(machine_power_off);
>...

Why?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

