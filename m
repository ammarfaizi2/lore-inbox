Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTELPy4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTELPy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:54:56 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:61085 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262257AbTELPyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:54:55 -0400
Date: Mon, 12 May 2003 17:08:09 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new kconfig goodies
Message-ID: <20030512160809.GD7079@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv> <20030512143207.GA6459@suse.de> <Pine.LNX.4.44.0305121737560.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305121737560.5042-100000@serv>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 05:39:45PM +0200, Roman Zippel wrote:

 > > Looks good. However, will this still offer the CONFIG_AGP tristate
 > > in the menu? If IOMMU is on, there must be no way to switch off
 > > the agpgart support on which it depends.
 > 
 > Yes, you will see AGP, but you can't change it.

Perfect!

		Dave
