Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWCYSiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWCYSiU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWCYSiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:38:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57359 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750753AbWCYSiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:38:19 -0500
Date: Sat, 25 Mar 2006 19:38:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] swsusp: finally solve mysqld problem
Message-ID: <20060325183817.GM4053@stusta.de>
References: <200602051321.55519.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602051321.55519.rjw@sisk.pl>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 01:21:54PM +0100, Rafael J. Wysocki wrote:

> Hi,

Hi Rafael,

> This patch from Pavel moves userland freeze signals handling into
> more logical place.  It now hits even with mysqld running.
>...

I've seen this patch has been included in Linus' tree.

What exactly was this "mysqld problem" problem, and more specifically, 
is this patch 2.6.16.2 material?

> Greetings,
> Rafael
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

