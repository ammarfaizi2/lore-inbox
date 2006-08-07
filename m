Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWHGMBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWHGMBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 08:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWHGMBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 08:01:20 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:21408 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1750818AbWHGMBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 08:01:20 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 7 Aug 2006 14:59:34 +0300
From: Tony Lindgren <tony@atomide.com>
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: akpm@osdl.org, juha.yrjola@solidboot.com, ext-timo.teras@nokia.com,
       r-woodruff2@ti.com, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net,
       kjh@hilman.org, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/2] OMAP: Add keypad driver #4
Message-ID: <20060807115933.GC10387@atomide.com>
References: <1154096354.24583.267091216@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154096354.24583.267091216@webmail.messagingengine.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060728 17:19]:
> Andrew/Tony/Rusell/Dmitry,
> 
> This is a revised patch as per the review comments from the RMK
> on thread:
> 
> http://lkml.org/lkml/2006/7/27/28
> 
> Please review it and give me the Ack if looks ok.
> 
> PS: omap24xx keypad code is still in omap-keypad.c.

That should be fine, the driver does pretty much the same thing for
omap1 and omap2.

Also earlier versions of this driver have been tested for quite a
while in the linux-omap tree so it would be nice to have it
merged.

Signed-off-by: Tony Lindgren <tony@atomide.com>
