Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274953AbTHAU3r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 16:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274957AbTHAU3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 16:29:47 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:32072 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S274953AbTHAU3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 16:29:46 -0400
Date: Fri, 1 Aug 2003 20:27:02 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Thomas Horsten <thomas@horsten.com>
Cc: linux-kernel@vger.kernel-org, arjanv@redhat.com, andre@linux-ide.org
Subject: Re: [PATCH] (2.4.2x) Driver for Medley software RAID (Silicon Image 3112 SATARaid, CMD680, etc?) for testing
Message-ID: <20030801202702.P6505@devserv.devel.redhat.com>
References: <Pine.LNX.4.40.0308012209180.29551-100000@jehova.dsm.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.40.0308012209180.29551-100000@jehova.dsm.dk>; from thomas@horsten.com on Fri, Aug 01, 2003 at 10:24:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01, 2003 at 10:24:13PM +0200, Thomas Horsten wrote:
> Hi,
> 
> I have written a driver for Medley software RAID as used by Silicon Image
> 3112 SATA IDE controller, and also other IDE RAID controllers like CMD680
> based ones (and possibly others). Currently it's only for 2.4.2X.
> 
> This driver uses the ATA RAID driver framework and is based on code from
> Arjan van de Ven's silraid.c and hptraid.c (it replaces the invalid
> silraid.c driver).

I'm curious. What makes you thnk silraid.c is invalid? And wouldn't it
have been easier to just fix whatever you were missing in silraid ??

Greetings,
   Arjan van de Ven
