Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270452AbRHHK7y>; Wed, 8 Aug 2001 06:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270454AbRHHK7s>; Wed, 8 Aug 2001 06:59:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56670 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S270451AbRHHK71>; Wed, 8 Aug 2001 06:59:27 -0400
To: ankry@green.mif.pg.gda.pl
Cc: rhw@MemAlpha.CX (Riley Williams), mra@pobox.com (Mark Atwood),
        linux-kernel@vger.kernel.org (Linux Kernel)
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <200108080841.KAA26569@sunrise.pg.gda.pl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Aug 2001 04:52:51 -0600
In-Reply-To: <200108080841.KAA26569@sunrise.pg.gda.pl>
Message-ID: <m11ymmvn5o.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz <ankry@pg.gda.pl> writes:

> 1. NFS-root needs to have RARP/NFS servers on eth0.
>    How can you deal with it if you have two boards supported by a single
>    driver and, unfortunately, the one you need is detected as eth1 ?
>    Assume that you cannot switch them as they use different media type...

Hmm.  Then my system that does DHCP/NFS root with 2.4.7 and comes up
on eth2 is doesn't work?  Hmm it looks like it works to me.

Eric
