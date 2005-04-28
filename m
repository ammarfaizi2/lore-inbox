Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVD1RRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVD1RRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVD1RRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:17:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:25773 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262177AbVD1RRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:17:19 -0400
Date: Thu, 28 Apr 2005 10:17:03 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: mark@ossholes.org, linux-kernel@vger.kernel.org
Subject: Re: Extremely poor umass transfer rates
Message-Id: <20050428101703.6204b734.rddunlap@osdl.org>
In-Reply-To: <20050428165915.GG30768@redhat.com>
References: <1114704142.8410.4.camel@mjollnir.bootless.dk>
	<20050428165915.GG30768@redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005 12:59:15 -0400
Dave Jones <davej@redhat.com> wrote:

> On Thu, Apr 28, 2005 at 06:02:22PM +0200, Mark Rosenstand wrote:
>  > I get transfer rates at around 30 kB/s to USB mass storage devices. It
>  > applies to both my keyring and my mp3 player. Both are running vfat.
>  > 
>  > I'm running 2.6.12-rc3 for amd64 with patches for inotify and skge. The
>  > motherboard is an ASUS K8V-X (VIA K8T800).
>  > 
>  > It worked alright earlier (2.6.10 or 2.6.11, I'll test later if
>  > necessary.)
>  > 
>  > Also, if I transfer more than one file at a time the music tracks start
>  > overlapping on my mp3 player.
> 
> Are you running it on a USB 2.0 capable interface ?
> Is your mp3 player USB2.0 capable ?
> USB1.1 is painfully slow for storage.

And which USB storage driver are you using (USB storage or
USB block driver)?  (or what device names are you mounting?)

---
~Randy
