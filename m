Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbULZSyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbULZSyK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbULZSyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:54:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:13465 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261733AbULZSsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:48:19 -0500
Subject: Re: Intel 810(E) driver in Kernel 2.6.10 - same problem as in 2.6.9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John McGowan <jmcgowan@inch.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041226000321.W98794@shell.inch.com>
References: <20041225193400.GA2700@localhost.localdomain>
	 <1104005852.23660.0.camel@localhost.localdomain>
	 <20041226000321.W98794@shell.inch.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104082455.15992.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 17:44:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-12-26 at 05:09, John McGowan wrote:
> To which version? 6.8.1 (rpm build from Fedora Core xorg-6.8.1-12.src.rpm).
> I see that 6.8.1 is the latest at xorg.

Right but there are patches in CVS beyond that and some are merged into
the FC testing/rawhide packages

> Fixed the memory or getting X to run at all on an 810?

I have 2D running nicely but not 3D

