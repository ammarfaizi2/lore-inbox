Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132578AbRDAXsg>; Sun, 1 Apr 2001 19:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132592AbRDAXs0>; Sun, 1 Apr 2001 19:48:26 -0400
Received: from zeus.kernel.org ([209.10.41.242]:9433 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132578AbRDAXsP>;
	Sun, 1 Apr 2001 19:48:15 -0400
Date: Sun, 1 Apr 2001 18:44:03 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: David Lang <dlang@diginsite.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
   "Albert D. Cahalan" <acahalan@cs.uml.edu>, lm@bitmover.com,
   linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.4.33.0104011632210.25794-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.3.96.1010401183934.6155B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, David Lang wrote:
> On Sun, 1 Apr 2001, Jeff Garzik wrote:
> > /sbin/installkernel copies stuff into /boot, appending a version number.
> > One way might be to have this script also copy the kernel config.

> could be, /sbin/installkernel doesn't exist on my systems

arch/i386/boot/install.sh has been calling /sbin/installkernel, if it
exists, for a good while now.

It sounds like your kernel or initscripts package is incomplete.
You can grab installkernel off a Mandrake- or RedHat-based system.

	Jeff




