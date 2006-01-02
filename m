Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWABRID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWABRID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 12:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWABRID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 12:08:03 -0500
Received: from cantor.suse.de ([195.135.220.2]:23480 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750906AbWABRIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 12:08:01 -0500
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.15-rc7: known regressions
Date: Mon, 2 Jan 2006 18:07:52 +0100
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org> <20060102164636.GH17398@stusta.de>
In-Reply-To: <20060102164636.GH17398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601021807.52533.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 January 2006 17:46, Adrian Bunk wrote:

> Subject    : x86_64: PANIC: early exception
> References : http://bugzilla.kernel.org/show_bug.cgi?id=5758
> Status     : Andi considers his patch too risky for 2.6.15,
>              workaround available, should be noted in the
>              final 2.6.15 announcement

If it worked in 2.6.14 then only by extreme luck and probably
also ran into problems later. The BIOS in this case is terminally broken. 

So I wouldn't consider this a real regression.

-Andi

