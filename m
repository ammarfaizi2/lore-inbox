Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752154AbWKANOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbWKANOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbWKANOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:14:35 -0500
Received: from outmx002.isp.belgacom.be ([195.238.5.52]:39143 "EHLO
	outmx002.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1752154AbWKANOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:14:34 -0500
Date: Wed, 1 Nov 2006 14:14:15 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Willy Tarreau <w@1wt.eu>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 45/61] Watchdog: sc1200wdt - fix missing pnp_unregister_driver()
Message-ID: <20061101131415.GA2927@infomag.infomag.iguana.be>
References: <20061101053340.305569000@sous-sol.org> <20061101054331.907620000@sous-sol.org> <20061101074525.GD543@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101074525.GD543@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy,

> > From: Akinobu Mita <akinobu.mita@gmail.com>
> > 
> > [WATCHDOG] sc1200wdt.c pnp unregister fix.
...
> 
> The first hunk seems to be valid for 2.4 too. The 2nd and 3rd ones
> were already in 2.4. Wim, I'm going to merge it. No objection ?

No objections. Please go ahead :-).

Greetings,
Wim.

