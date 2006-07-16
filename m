Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWGPToG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWGPToG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 15:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWGPToG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 15:44:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:14240 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750834AbWGPToF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 15:44:05 -0400
Subject: Re: crash in aty128_set_lcd_enable on PowerBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <20060716192727.GA17387@suse.de>
References: <20060716163728.GA16228@suse.de>
	 <20060716165004.GA16369@suse.de>
	 <1153077550.5905.33.camel@localhost.localdomain>
	 <1153077953.5905.37.camel@localhost.localdomain>
	 <20060716192727.GA17387@suse.de>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 15:43:35 -0400
Message-Id: <1153079015.5905.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-16 at 21:27 +0200, Olaf Hering wrote:
>  On Sun, Jul 16, Benjamin Herrenschmidt wrote:
> 
> > 
> > > Yeah, that looks like some serious bogosity in that code. Care to send a
> > > patch ?
> > 
> > (I'm in a hotel room in Ottawa with no r128 at hand to test so I'm not
> > doing it myself just now :)
> 
> It crashes later for different reasons. The whole init process works by
> luck it seems.

I've been having weird things happening with latest linus trees and
really no time to debug ... do you have a backtrace for the "other"
crash ?

Ben.


