Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWABMRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWABMRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 07:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWABMRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 07:17:46 -0500
Received: from mail.gmx.net ([213.165.64.21]:8396 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932222AbWABMRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 07:17:45 -0500
X-Authenticated: #5082238
Date: Mon, 2 Jan 2006 13:17:52 +0100
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Intel e1000 fails after RAM upgrade
Message-ID: <20060102121752.GA29275@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051219195458.GA23650@carsten-otto.halifax.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219195458.GA23650@carsten-otto.halifax.rwth-aachen.de>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 08:54:58PM +0100, Carsten Otto wrote:
> e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang

Is there anything I can do to make this work and/or you have more fun
and luck fixing this? I could provide plenty of debugging information,
just tell me what you need. Unfortunately I am unable to solve the
problem myself.

Short summary:
Every e1000 card I tried (Desktop MT) produces above error in my
computer and works in other PCs. Memory/BIOS/Kernel-version do not
change this. Either the kernel is flawed in several versions or my system
(Gentoo) does some ugly things to the driver (I doubt that). Changing some
values with ethtool does not help.

Thanks,
-- 
Carsten Otto
c-otto@gmx.de
www.c-otto.de
