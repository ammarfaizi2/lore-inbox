Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132591AbRDAXm4>; Sun, 1 Apr 2001 19:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132592AbRDAXmq>; Sun, 1 Apr 2001 19:42:46 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:20650 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S132591AbRDAXm2>; Sun, 1 Apr 2001 19:42:28 -0400
Date: Sun, 1 Apr 2001 16:32:55 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
   "Albert D. Cahalan" <acahalan@cs.uml.edu>, <lm@bitmover.com>,
   <linux-kernel@vger.kernel.org>
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.3.96.1010401183332.6155A-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0104011632210.25794-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

could be, /sbin/installkernel doesn't exist on my systems

David Lang

On Sun, 1 Apr 2001, Jeff Garzik wrote:

> Date: Sun, 1 Apr 2001 18:34:07 -0500 (CDT)
> From: Jeff Garzik <jgarzik@mandrakesoft.com>
> To: David Lang <dlang@diginsite.com>
> Cc: Manfred Spraul <manfred@colorfullife.com>,
>      Albert D. Cahalan <acahalan@cs.uml.edu>, lm@bitmover.com,
>      linux-kernel@vger.kernel.org
> Subject: Re: bug database braindump from the kernel summit
>
> On Sun, 1 Apr 2001, David Lang wrote:
> > /proc/config may be bloat, but we do need a way for the kernel config to
> > be tied to the kernel image that is running, however it is made available.
>
> /sbin/installkernel copies stuff into /boot, appending a version number.
> One way might be to have this script also copy the kernel config.
>
> 	Jeff
>
>
>
>

