Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWHSPuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWHSPuu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 11:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWHSPut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 11:50:49 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:54813 "EHLO
	asav04.insightbb.com") by vger.kernel.org with ESMTP
	id S1751405AbWHSPut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 11:50:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAJvO5kSBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Polling for battery stauts and lost keypresses
Date: Sat, 19 Aug 2006 11:50:46 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl> <d120d5000608141317p50540cd5x5e8ec409dc9343ef@mail.gmail.com> <gd60xm38im9j.a4xxz8tjb0qj$.dlg@40tude.net>
In-Reply-To: <gd60xm38im9j.a4xxz8tjb0qj$.dlg@40tude.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608191150.47183.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 03:31, Giuseppe Bilotta wrote:
> On Mon, 14 Aug 2006 16:17:01 -0400, Dmitry Torokhov wrote:
> 
> > 2. Quite often there are OEM drivers that are tweaked to a specific
> > hardware and involve hardware-specific hacks.
> 
> If I remember correctly (damn, I can't find a way to do a search on
> the LKML archives ...) there was someone working on Dell stuff, at
> least as far as fans and thermal sensors were concerned (based on the
> code from Massimo Dal Zotto) to integrate them with the kernel sensors
> framework. However, some of those patches where NACKed by someone from
> Dell because they were sort of "guessy" about the addresses to poke
> around to get the information, instead of using the data provided by
> the BIOS on where to look for them ... however, there hasn't been any
> news about that that stuff since ...
> 

As far as I remember that person from Dell was not ready to disclose
details of their SMBIOS :( so it naturally went nowhere.
 
-- 
Dmitry
