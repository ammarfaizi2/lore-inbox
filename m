Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWGPTuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWGPTuL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 15:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWGPTuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 15:50:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18343 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932082AbWGPTuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 15:50:10 -0400
Date: Sun, 16 Jul 2006 21:50:08 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: crash in aty128_set_lcd_enable on PowerBook
Message-ID: <20060716195008.GA17557@suse.de>
References: <20060716163728.GA16228@suse.de> <20060716165004.GA16369@suse.de> <1153077550.5905.33.camel@localhost.localdomain> <1153077953.5905.37.camel@localhost.localdomain> <20060716192727.GA17387@suse.de> <1153079015.5905.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1153079015.5905.39.camel@localhost.localdomain>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Jul 16, Benjamin Herrenschmidt wrote:

> > It crashes later for different reasons. The whole init process works by
> > luck it seems.
> 
> I've been having weird things happening with latest linus trees and
> really no time to debug ... do you have a backtrace for the "other"
> crash ?

It was in aty128_bl_set_power(), cant remember the trace.
