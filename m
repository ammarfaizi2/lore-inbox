Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWH1QGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWH1QGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWH1QGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:06:03 -0400
Received: from mga03.intel.com ([143.182.124.21]:45181 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751131AbWH1QGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:06:01 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,176,1154934000"; 
   d="scan'208"; a="108604959:sNHT12455481857"
Message-ID: <44F30B25.2030906@intel.com>
Date: Mon, 28 Aug 2006 08:26:29 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john.ronciak@intel.com, jesse.brandeburg@intel.com
Subject: Re: e1000 driver contains private copy of GPL... and modified one,
 too
References: <20060827082534.GA2397@elf.ucw.cz>
In-Reply-To: <20060827082534.GA2397@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Aug 2006 16:05:54.0443 (UTC) FILETIME=[D72DB5B0:01C6CABB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> Okay, so modifications are not major: different address of free
> software foundation, completely different formatting, some characters
> added, and some characters removed. It no longer contains Linus'
> clarifications.
> 
> --- LICENSE     2006-07-21 05:42:27.000000000 +0200
> +++ ../../../COPYING    2006-07-21 05:42:27.000000000 +0200
> @@ -1,128 +1,141 @@

[snip]

> 
> Now... I believe nothing evil is going on, but having two slightly
> different copies of GPL in one source seems wrong, can we get rid of
> e1000 one?

I'll ask around here and see if this doesn't make people cringe. Meanwhile 
Pavel should examine sound/oss/COPYING and arch/sparc/lib/COPYING.LIB too :)

Cheers,

Auke
