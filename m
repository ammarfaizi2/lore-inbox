Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUD1Uq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUD1Uq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUD1UDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:03:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51887 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261389AbUD1TRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:17:12 -0400
Date: Tue, 27 Apr 2004 16:14:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: tj <999alfred@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmc/sd drivers
Message-ID: <20040427141453.GQ2595@openzaurus.ucw.cz>
References: <408D3DC0.8080700@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408D3DC0.8080700@comcast.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Where can the latest mmc drivers in the kernel source be located? I 
> am not talking about mass-storage usb or pcmcia drivers. I downloaded 
> 2.2.26 and there is no drivers/mmc directory. Where can the mmc 
> drivers be located from their original distribution point?
> 

2.2 is old.

MMC is supported for example on sharp zaurus, look
there for sources. SD requires binary-only module. Avoid it.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

