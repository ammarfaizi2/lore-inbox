Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUBRGB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 01:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUBRGB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 01:01:56 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:20996 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264275AbUBRGBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 01:01:55 -0500
Date: Wed, 18 Feb 2004 06:57:44 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-rc4
Message-ID: <20040218055744.GC15660@alpha.home.local>
References: <Pine.LNX.4.58L.0402180207540.4852@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402180207540.4852@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Wed, Feb 18, 2004 at 02:11:24AM -0300, Marcelo Tosatti wrote:
> Here goes release candidate 4, including a few small fixes.
> 
> If nothing bad shows up, this will become final.

Well, I would have liked to see the ACPI poweroff fix I sent a few days ago,
but Len said he doesn't have time to review it this week. It's a shame since
at least two of my machines which powered off correctly with very older ACPI
versions now need it, so I don't think I'm the only one in this case :-(

Other than that, I'm fairly happy with at least -rc2 (not tested latest
releases yet).

Cheers,
Willy

