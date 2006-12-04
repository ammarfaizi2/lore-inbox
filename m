Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760057AbWLEOON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760057AbWLEOON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 09:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760066AbWLEOON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 09:14:13 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3782 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760057AbWLEOOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 09:14:12 -0500
Date: Mon, 4 Dec 2006 19:59:01 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jean Delvare <khali@linux-fr.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: reenable Asus SMBus quirks on resume
Message-ID: <20061204195901.GA4388@ucw.cz>
References: <20061114175510.6e7c7119@localhost.localdomain> <20061204135137.f2877516.khali@linux-fr.org> <20061204131409.4734fa73@localhost.localdomain> <20061204183715.fd710e55.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204183715.fd710e55.khali@linux-fr.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Now that PCI quirks are replayed on software resume, we can safely
> re-enable the Asus SMBus unhiding quirk even when software suspend
> support is enabled.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>

ACK...
							Pavel

-- 
Thanks for all the (sleeping) penguins.
