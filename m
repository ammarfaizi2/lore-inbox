Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270850AbUJVIvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270850AbUJVIvF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270871AbUJVIvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:51:04 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:30115 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S270850AbUJVItJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 04:49:09 -0400
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
From: Adrian Cox <adrian@humboldt.co.uk>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4177ABC9.8291.20E9CB7A@localhost>
References: <4176E08B.2050706@techsource.com>
	 <4177ABC9.8291.20E9CB7A@localhost>
Content-Type: text/plain
Message-Id: <1098434942.5755.34.camel@newt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 09:49:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 20:30, Kendall Bennett wrote:

> Most embedded customers care less about overall performance of the 
> graphics hardware but more about low cost, low power and longevity. That 
> is the reason that ATI committed to continue production of the Radeon 
> Mobility M1 for many years to come. That is also the reason the Chips & 
> Tech (now Asiliant) 6900 chipset is so popular for embedded customers, 
> because they have been using the same hardware for years (but now that 
> the 69000 is winding down, many are moving to the Mobility M1).

Also consider the Fujitsu Coral parts for embedded use:
http://www.fme.gsdc.de/gsdc.htm?macrofam/mb86295.htm

They have a large manual, though I can't vouch for completeness. They
have 3D and alpha blending. They don't have legacy VGA registers, and
they don't have a VGA BIOS. In an embedded system, that's a bonus.

This is the competition facing a new open source graphics chip in the
embedded segment. 

- Adrian Cox
Humboldt Solutions Ltd.


