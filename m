Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264699AbVBDOly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264699AbVBDOly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbVBDOly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:41:54 -0500
Received: from styx.suse.cz ([82.119.242.94]:13442 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S264699AbVBDOlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 09:41:46 -0500
Date: Fri, 4 Feb 2005 15:42:01 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] Kconfig: cleanup input menu
Message-ID: <20050204144201.GA1661@ucw.cz>
References: <Pine.LNX.4.61.0501292320090.7662@scrub.home> <200501292127.29418.dtor_core@ameritech.net> <Pine.LNX.4.61.0501300409300.6118@scrub.home> <200501292307.55193.dtor_core@ameritech.net> <Pine.LNX.4.61.0501301639171.30794@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501301639171.30794@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 04:45:35PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Sat, 29 Jan 2005, Dmitry Torokhov wrote:
> 
> > Ok, what about making some submenus to manage number of options, like in
> > the patch below?
> 
> I'd rather move it to the bottom and the menus had no dependencies.
> Below is an alternative patch, which does a rather complete cleanup.

Applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
