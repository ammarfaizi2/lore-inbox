Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbVIVSGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVIVSGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 14:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbVIVSGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 14:06:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3546 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750908AbVIVSGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 14:06:08 -0400
Date: Thu, 22 Sep 2005 20:05:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rishikeshsn <rishikeshsn@indiatimes.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: to see 802.11 frames thru kernel code
Message-ID: <20050922180551.GB27011@elf.ucw.cz>
References: <200509191711.WAA28816@WS0005.indiatimes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509191711.WAA28816@WS0005.indiatimes.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> i want to know:
> 
> can i see 802.11 frames in skbuff structure?
> I get only ethernet II frame format.

See jirka&jirka's wireless patches. They can do that.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
