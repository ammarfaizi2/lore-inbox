Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVGLIkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVGLIkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 04:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVGLIhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 04:37:53 -0400
Received: from [203.171.93.254] ([203.171.93.254]:56033 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261270AbVGLIhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 04:37:42 -0400
Subject: Re: [PATCH] [28/48] Suspend2 2.1.9.8 for 2.6.12:
	605-kernel_power_suspend.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710175810.GA10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <1120616442343@foobar.com>
	 <20050710175810.GA10904@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121157563.13869.129.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 18:39:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-07-11 at 03:58, Pavel Machek wrote:
> Hi!
> 
> > diff -ruNp 606-all-settings.patch-old/kernel/power/suspend2_core/all_settings.c 606-all-settings.patch-new/kernel/power/suspend2_core/all_settings.c
> > --- 606-all-settings.patch-old/kernel/power/suspend2_core/all_settings.c	1970-01-01 10:00:00.000000000 +1000
> > +++ 606-all-settings.patch-new/kernel/power/suspend2_core/all_settings.c	2005-07-04 23:14:19.000000000 +1000

[...]

> > + * This entry allows all of the settings to be set at once. 
> > + * It was originally for compatibility with pre- /proc/suspend
> > + * versions, but has been retained because it makes saving and
> > + * restoring the configuration simpler.
> > + */
> 
> Okay, and it is also extremely ugly. Now you have chance to clean it
> up, please drop it.

After checking with users, done.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

