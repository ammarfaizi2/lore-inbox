Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVJKNtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVJKNtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVJKNtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:49:50 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:17051 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S932078AbVJKNtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:49:50 -0400
X-ORBL: [67.117.73.34]
Date: Tue, 11 Oct 2005 16:49:38 +0300
From: Tony Lindgren <tony@atomide.com>
To: jonathan@jonmasters.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nokia 770 kernel sources?
Message-ID: <20051011134936.GA12462@atomide.com>
References: <35fb2e590510101708l497a44a5oe71971e9c3c925a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e590510101708l497a44a5oe71971e9c3c925a9@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jon Masters <jonmasters@gmail.com> [051011 03:09]:
> Hi folks,
> 
> Anyone know if a vanilla 2.6 omap1 kernel is supposed to "just work" on the 770?

A lot of the 770 stuff already been merged, but there are
still some more patches coming. So you should be able to use
the linux-omap tree at some point.

All the core omap stuff we merge with the mainline kernel on
regular basis, but some omap specific drivers will probably
never make it to the mainline tree because they are only
used on development boards etc.

Regards,

Tony
