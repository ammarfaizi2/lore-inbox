Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934457AbWK1CPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934457AbWK1CPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 21:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934459AbWK1CPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 21:15:30 -0500
Received: from nlpi015.sbcis.sbc.com ([207.115.36.44]:39816 "EHLO
	nlpi015.sbcis.sbc.com") by vger.kernel.org with ESMTP
	id S934457AbWK1CP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 21:15:29 -0500
X-ORBL: [67.117.73.34]
Date: Tue, 28 Nov 2006 02:15:00 +0000
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: Siemens sx1: merge framebuffer support
Message-ID: <20061128021459.GA7763@atomide.com>
References: <20061118181607.GA15275@elf.ucw.cz> <20061120190404.GD4597@atomide.com> <20061124110222.GB5608@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124110222.GB5608@elf.ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [061124 11:03]:
> Hi!
> 
> 
> > > 
> > > Framebuffer support for Siemens SX1; this is second big patch. (Third
> > > one will be mixer/sound support). Support is simple / pretty minimal,
> > > but seems to work okay (and is somehow important for a cell phone :-).
> > 
> > Pushed to linux-omap. I guess you're planning to send the missing
> > Kconfig + Makefile patch for this?
> 
> Yes, here it is. Actually no Kconfig change should be neccessary.

Thanks, pushing today to linux-omap.

Tony
