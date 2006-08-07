Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWHGMYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWHGMYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 08:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWHGMYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 08:24:08 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:4041 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S932093AbWHGMYH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 08:24:07 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 7 Aug 2006 15:04:37 +0300
From: Tony Lindgren <tony@atomide.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Komal Shah <komal_shah802003@yahoo.com>, gdavis@mvista.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       dbrownell@users.sourceforge.net, r-woddruff2@ti.com
Subject: Re: [PATCH] OMAP: Add Watchdog driver support
Message-ID: <20060807120436.GD10387@atomide.com>
References: <1153567435.16250.266622064@webmail.messagingengine.com> <20060801201453.GA3912@infomag.infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801201453.GA3912@infomag.infomag.iguana.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Wim Van Sebroeck <wim@iguana.be> [060801 23:15]:
> Hi Komal Shah,
> 
> > Attached patch addes Texas Instruments (TI) OMAP1/2 (http://www.ti.com/omap)
> > based processors, like OMAP1610/1710/242x.
> 
> In the process of reviewing your driver.

This driver too has been in use in the linux-omap tree for quite a
while. As far as I'm concerned:

Signed-off-by: Tony Lindgren <tony@atomide.com>
