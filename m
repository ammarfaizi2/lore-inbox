Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWDTQ6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWDTQ6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWDTQ63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:58:29 -0400
Received: from albireo.ucw.cz ([84.242.87.5]:39300 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1751138AbWDTQ63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:58:29 -0400
Date: Thu, 20 Apr 2006 18:58:24 +0200
From: Martin Mares <mj@ucw.cz>
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "Yu, Luming" <luming.yu@intel.com>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <mj+md-20060420.165714.18107.albireo@ucw.cz>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4447AF4D.7030507@linux.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Generic application does not need to know if power, sleep, or lid button is 
> pressed, so you will need to intercept them from input stream... I cannot 
> find any reason to mix these buttons into input, do you?

Neither does a generic application need to know if the NumLock key is just
pressed. This doesn't mean anything.

I don't see any reason for treating some keys or buttons differently.
A key is just a key.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: How many alchemists does it take to change a light bulb?  A: Into what?
