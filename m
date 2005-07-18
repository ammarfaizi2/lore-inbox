Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVGRHYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVGRHYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 03:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVGRHWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 03:22:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51140 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261560AbVGRHVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 03:21:02 -0400
Message-ID: <42DB4706.9010304@suse.de>
Date: Mon, 18 Jul 2005 08:07:02 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322 Thunderbird/1.0.2 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frederic Gaus <mailinglists@necroshine.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA_SOCKET unable to apply filter after Ram Upgrade
References: <42D92530.1020300@necroshine.de>
In-Reply-To: <42D92530.1020300@necroshine.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Gaus wrote:
> Hi folks!
> 
> I've recently done a RAM upgrade on my IBM Thinkpad R40 (2722).
> 
> 1. Ram-Chip: pc2100 cl 2.5 512 MB
> 2. Ram-Chip: pc2700 cl 2.5 1024 MB
> 
> When booting with only one Chip inside, everything works perfecly.
> (Never mind in which slot). But when using both, I get this error
> message every few seconds:
> 
> 	kernel: cs: pcmcia_socket0: unable to apply power.

Are you overriding the DSDT?
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

