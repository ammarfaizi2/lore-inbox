Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267872AbUG3XpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267872AbUG3XpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 19:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267868AbUG3XpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 19:45:07 -0400
Received: from the-village.bc.nu ([81.2.110.252]:37543 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267872AbUG3XpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 19:45:01 -0400
Subject: Re: Exposing ROM's though sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jon Smirl <jonsmirl@yahoo.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200407301320.19892.jbarnes@engr.sgi.com>
References: <20040730193546.GA328@ucw.cz>
	 <20040730194150.7072.qmail@web14927.mail.yahoo.com>
	 <20040730194854.GA436@ucw.cz>  <200407301320.19892.jbarnes@engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091227263.5054.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 30 Jul 2004 23:41:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-07-30 at 21:20, Jesse Barnes wrote:
> I think Martin's suggestion of just caching them all at probe time (or 
> optionally at driver attach time) is probably the simplest and easiest to get 
> right.  It could be controllable via a boot time parameter.  But I'm not 
> entirely opposed to using pci quirks.

You guys just have *too* much RAM.

