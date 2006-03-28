Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWC1AVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWC1AVr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWC1AVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:21:47 -0500
Received: from mail.tmr.com ([64.65.253.246]:48357 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1751162AbWC1AVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:21:47 -0500
Message-ID: <44288197.50908@tmr.com>
Date: Mon, 27 Mar 2006 19:21:43 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: linux@horizon.com, Linux Kernel M/L <linux-kernel@vger.kernel.org>
Subject: Re: Lifetime of flash memory
References: <20060323074929.26749.qmail@science.horizon.com>
In-Reply-To: <20060323074929.26749.qmail@science.horizon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:

> On a hard drive, the head never touches the media.  There is no wear.
> The magnetic writing happens across a very small air gap, and nobody's
> ever found a wearout mechanism for the magnetizing part of things, so you
> should be able to overwrite a single sector every rotation of the drive
> (120 times a second) for the lifetime of the drive (years).

Not for disk. When we were running early MULTICS on the mighty GE-645, 
paging was to a "firehose drum" which wrote either mainly or exclusively 
into one part of core memory, creating enough heat (according to the 
FEs) to cause very low MTBF on that box of memory.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

