Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUFDMZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUFDMZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 08:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265769AbUFDMZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 08:25:27 -0400
Received: from gprs214-121.eurotel.cz ([160.218.214.121]:1665 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265701AbUFDMZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 08:25:26 -0400
Date: Fri, 4 Jun 2004 14:25:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core fixes for 2.6.7-rc1
Message-ID: <20040604122518.GB11950@elf.ucw.cz>
References: <10857795552653@kroah.com> <10857795552130@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10857795552130@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [PATCH] Report which device failed to suspend
> 
> Based on a patch from Nickolai Zeldovich <kolya@MIT.EDU> but put into the
> proper place by me.

Seems good.

I'm seeing lots of problems with drivers & swsusp these days. Perhaps
even printing names of devices as they are suspended is good idea?

								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc
