Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132587AbRDAXf0>; Sun, 1 Apr 2001 19:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132589AbRDAXfG>; Sun, 1 Apr 2001 19:35:06 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:14899 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132587AbRDAXez>; Sun, 1 Apr 2001 19:34:55 -0400
Date: Sun, 1 Apr 2001 18:34:07 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: David Lang <dlang@diginsite.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
   "Albert D. Cahalan" <acahalan@cs.uml.edu>, lm@bitmover.com,
   linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.4.33.0104011618540.25794-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.3.96.1010401183332.6155A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, David Lang wrote:
> /proc/config may be bloat, but we do need a way for the kernel config to
> be tied to the kernel image that is running, however it is made available.

/sbin/installkernel copies stuff into /boot, appending a version number.
One way might be to have this script also copy the kernel config.

	Jeff




