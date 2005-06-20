Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVFTTaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVFTTaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVFTT1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:27:17 -0400
Received: from mxout1.netvision.net.il ([194.90.9.20]:2894 "EHLO
	mxout1.netvision.net.il") by vger.kernel.org with ESMTP
	id S261537AbVFTT0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:26:30 -0400
Date: Mon, 20 Jun 2005 23:29:04 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: 2.6.12: codec_semaphore: semaphore is not ready
In-reply-to: <200506201809.15739.s0348365@sms.ed.ac.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Rafael Rodr?guez <apt-drink@gulic.org>, linux-kernel@vger.kernel.org
Mail-followup-to: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
 Rafael Rodr?guez <apt-drink@gulic.org>, linux-kernel@vger.kernel.org
Message-id: <20050620202904.GA11614@sashak.softier.local>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <200506191402.02287.apt-drink@gulic.org>
 <s5hy895p8gg.wl%tiwai@suse.de> <200506201446.20541.apt-drink@gulic.org>
 <200506201809.15739.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:09 Mon 20 Jun     , Alistair John Strachan wrote:
> 
> I've found that my snd-intel8x0m modem works fine despite the codec_semaphore 
> warnings, so I think it can be ignored by the majority. This also isn't a 
> 2.6.12 problem, it's been happening for ages.

Yes, and hopefully this warning is fixed already in ALSA CVS.

Sasha.

