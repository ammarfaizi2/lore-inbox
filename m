Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWHGMHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWHGMHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 08:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWHGMHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 08:07:54 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:57511 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932068AbWHGMHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 08:07:53 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 7 Aug 2006 15:07:13 +0300
From: Tony Lindgren <tony@atomide.com>
To: Michael Buesch <mb@bu3sch.de>
Cc: Komal Shah <komal_shah802003@yahoo.com>, dsaxena@plexity.net,
       juha.yrjola@solidboot.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OMAP: Fix RNG driver build
Message-ID: <20060807120712.GE10387@atomide.com>
References: <1153569662.17307.266622961@webmail.messagingengine.com> <200607221854.45293.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607221854.45293.mb@bu3sch.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Buesch <mb@bu3sch.de> [060722 19:56]:
> On Saturday 22 July 2006 14:01, Komal Shah wrote:
> > Michael/Deepak/Juha,
> > 
> > Attached patch fixes the following RNG driver build warnings and errors:
> 
> I don't have the hardware, so I can't test this.
> Deepak, do you have the hardware and can you ack this?

This is safe to push and has been used in the linux-omap tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
