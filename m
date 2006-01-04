Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWADK5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWADK5y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbWADK5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:57:54 -0500
Received: from vvv.conterra.de ([212.124.44.162]:63413 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S1751681AbWADK5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:57:53 -0500
Message-ID: <43BBAA25.5000907@conterra.de>
Date: Wed, 04 Jan 2006 11:57:41 +0100
From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64 + VIA + 4g problems
References: <43B90A04.2090403@conterra.de> <p73k6difvm3.fsf@verdi.suse.de>	<43BA4C3D.4060206@conterra.de> <p731wzpjtvm.fsf@verdi.suse.de>
In-Reply-To: <p731wzpjtvm.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Does everything work (including the SKGE) driver
> when you boot with swiotlb=force ? 

I just realize there are TWO modules to get my 3c940 running:
skge and sk98lin. All my problems posted so far were related
to the sk98lin module, I used until now. I'll try to use the
skge module as soon as I'm able to reboot.

Dieter.
-- 
Dieter Stüken, con terra GmbH, Münster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
