Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265376AbUGDDXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265376AbUGDDXP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 23:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUGDDXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 23:23:15 -0400
Received: from colin2.muc.de ([193.149.48.15]:8965 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265376AbUGDDXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 23:23:14 -0400
Date: 4 Jul 2004 05:23:12 +0200
Date: Sun, 4 Jul 2004 05:23:12 +0200
From: Andi Kleen <ak@muc.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird:  30 sec delay during early boot
Message-ID: <20040704032312.GA90194@muc.de>
References: <2e55c-392-7@gated-at.bofh.it> <m3hdsoebe8.fsf@averell.firstfloor.org> <40E7710A.4020601@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40E7710A.4020601@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> would early printk show something that dmesg(8) would not?

Yes, it's real time and you can see where the delay occurs.

-Andi
