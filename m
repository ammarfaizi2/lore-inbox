Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266625AbUAWUdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 15:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266651AbUAWUdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 15:33:54 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:58307 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S266625AbUAWUdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 15:33:53 -0500
Date: Fri, 23 Jan 2004 14:24:49 -0500
From: Ben Collins <bcollins@debian.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux1394-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Message about PCILynx in kernel config
Message-ID: <20040123192449.GR27566@phunnypharm.org>
References: <20040123210520.08108f9f.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123210520.08108f9f.khali@linux-fr.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think it might be confusing, so I suggest that the message shouldn't
> be displayed at all if PCI isn't selected. And here's a simple patch
> that does just this. Built against and tested on Linux 2.6.2-rc1.

Applied, thanks.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
