Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWGPT13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWGPT13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 15:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWGPT13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 15:27:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:677 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751178AbWGPT12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 15:27:28 -0400
Date: Sun, 16 Jul 2006 21:27:27 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: crash in aty128_set_lcd_enable on PowerBook
Message-ID: <20060716192727.GA17387@suse.de>
References: <20060716163728.GA16228@suse.de> <20060716165004.GA16369@suse.de> <1153077550.5905.33.camel@localhost.localdomain> <1153077953.5905.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1153077953.5905.37.camel@localhost.localdomain>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Jul 16, Benjamin Herrenschmidt wrote:

> 
> > Yeah, that looks like some serious bogosity in that code. Care to send a
> > patch ?
> 
> (I'm in a hotel room in Ottawa with no r128 at hand to test so I'm not
> doing it myself just now :)

It crashes later for different reasons. The whole init process works by
luck it seems.
