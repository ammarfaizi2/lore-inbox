Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVG1O7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVG1O7D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVG1OyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:54:02 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27909 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261534AbVG1Ow4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:52:56 -0400
Date: Thu, 28 Jul 2005 16:52:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Kevin Radloff <radsaq@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI processor C-state regression in 2.6.13-rc3?
Message-ID: <20050728145254.GL3528@stusta.de>
References: <3b0ffc1f05071309396353066b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b0ffc1f05071309396353066b@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 12:39:13PM -0400, Kevin Radloff wrote:

> With the ACPI merge in 2.6.13-rc3, C2 and C3 processor states are no
> longer detected/enabled on my Fujitsu Lifebook P7010D. Enabling ACPI
> debugging doesn't result in any extra info about this being reported.
> I assume it's related to the changes to enable C2/3 on SMP..
> 
> Please CC me with any followups, as I'm not on the list.

Is this problem still present in 2.6.13-rc3-mm3?

If yes, please file a bug report at the kernel Bugzilla [1].

> Kevin 'radsaq' Radloff

cu
Adrian

[1] http://bugzilla.kernel.org/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

