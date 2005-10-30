Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVJ3SOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVJ3SOM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVJ3SOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:14:12 -0500
Received: from main.gmane.org ([80.91.229.2]:16018 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932188AbVJ3SOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:14:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [patch 0/5] HW RNG cleanup & new drivers
Date: Mon, 31 Oct 2005 03:08:58 +0900
Message-ID: <dk32bf$quc$1@sea.gmane.org>
References: <20051029191229.562454000@omelas> <4363F31F.2040303@pobox.com> <200510292023.01984.gene.heskett@verizon.net> <200510301431.54439.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
In-Reply-To: <200510301431.54439.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Sunday 30 October 2005 01:23, Gene Heskett wrote:
> [snip]
> 
>>Does anyone know if there is a hardware RNG in my Athlons?  XP-2800
>>here, XP-1400 in the shop box, & a K6-III in the firewall.
> 
> 
> It's a mainboard feature, not a CPU feature.

And is there a docmentation on how to find which RNG device you have?
Or is there lsrng (like lspci) :-)
Most of the device names I have never heard of, but working with 5+ MB vendors and all the different
models of MB I really have no idea where do I have this and that...

So, any method of autodetecting a RNG device?

And a question, I always wanted to ask: is there a cheap hardware random device usable in linux that
is PCI/USB/serial whatever pluggable? For MBs without RNG in the chipset.

Kalin.
-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

