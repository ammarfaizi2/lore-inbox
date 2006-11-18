Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752375AbWKRVKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbWKRVKA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 16:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752385AbWKRVKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 16:10:00 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:60828 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1752367AbWKRVJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 16:09:57 -0500
Date: Sat, 18 Nov 2006 13:09:57 -0800
From: thockin@hockin.org
To: linux-kernel@vger.kernel.org
Subject: Re: boot from efi on x86_64
Message-ID: <20061118210957.GA5117@hockin.org>
References: <200611182107.03667.spatz@psybear.com> <20061118204013.GA13645@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118204013.GA13645@irc.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 09:40:13PM +0100, Tomasz Torcz wrote:
> On Sat, Nov 18, 2006 at 09:07:03PM +0200, Dror Levin wrote:
> > looking at the kernel source, after constant failures to boot linux on a core 
> > 2 imac, has made me understand that only i386 and ia64 support efi booting, 
> > but x86_64 does not.
> > it makes sense, if you think about it... AFAIK, until the new core 2 imacs 
> > were out there was no x86_64 efi pc, so why should the kernel support it?
> 
>   Few days ago I played with Intel servers with EM64T Xeons (NetBurst
> based). They are x86_64, and motherboard (Intel chipset) utilised EFI.

but did it use GRUB or elilo ?
