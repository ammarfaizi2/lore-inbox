Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVGGV2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVGGV2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVGGV04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:26:56 -0400
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:36024 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261539AbVGGVYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:24:17 -0400
Date: Thu, 7 Jul 2005 23:24:43 +0200
From: Mattia Dongili <malattia@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: Synaptics Touchpad not detected in 2.6.13-rc2
Message-ID: <20050707212442.GA4054@inferi.kami.home>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	vojtech@suse.cz, Dmitry Torokhov <dtor@mail.ru>
References: <20050707193027.GA4162@inferi.kami.home> <20050707200238.52898.qmail@web81308.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707200238.52898.qmail@web81308.mail.yahoo.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.13-rc2-mm1-2 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 01:02:38PM -0700, Dmitry Torokhov wrote:
> Mattia Dongili <malattia@gmail.com> wrote:
[...]
> > This is the device (on a Vaio GR), which other info could I provide to
> > better diagnose the problem?
> > 
> 
> Could you please do "echo 1 > /sys/modules/i8042/parameters/debug";
> reload psmouse module and send me dmesg please?

oh, it seems I'm not able to reproduce the error anymore!
I need some rest now, I'll try again tomorrow morning (I must be missing
something stupid right now) and report to you again.

Thanks
-- 
mattia
:wq!
