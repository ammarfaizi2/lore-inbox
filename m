Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUGHUvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUGHUvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 16:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUGHUvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 16:51:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20168 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264639AbUGHUvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 16:51:16 -0400
Date: Thu, 8 Jul 2004 22:32:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] New set of input patches
Message-ID: <20040708203200.GA607@openzaurus.ucw.cz>
References: <200407080155.07827.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407080155.07827.dtor_core@ameritech.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 03-i8042-broken-mux-workaround.patch
> 	- Some MUXes get confused what AUX port the byte came from. Assume
> 	  that is came from the same port previous byte came from if it
> 	  arrived within HZ/10

Does that mean that (even if my hw is ok) when I two mice at once
I get random movements?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

