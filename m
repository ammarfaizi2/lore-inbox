Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbRCTVtO>; Tue, 20 Mar 2001 16:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130903AbRCTVsy>; Tue, 20 Mar 2001 16:48:54 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:20394 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130820AbRCTVsx>;
	Tue, 20 Mar 2001 16:48:53 -0500
Message-ID: <3AB7CFF1.FFC17E31@mandrakesoft.com>
Date: Tue, 20 Mar 2001 16:47:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Manuel A. McLure" <mmt@unify.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: NETDEV WATCHDOG: eth0: transmit timed out on LNE100TX 4.0, 
 kernel2.4.2-ac11 and earlier.
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C134@pcmailsrv1.sac.unify.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Manuel A. McLure" wrote:
> 
> System:
> AMD Athlon Thunderbird 900MHz
> MSI K7T Pro (VIA KT133 chipset)
> Network card: Linksys LNE100TX Rev. 4.0 (tulip)
> Kernel: 2.2.18 (with 0.92 Scyld drivers), 2.4.0, 2.4.1, 2.4.2, 2.4.2-ac11
> 
> With all the above kernel revisions/drivers, my network card hangs at random
> (sometimes within minutes, other times it takes days). To restart it I need
> to do an ifdown/ifup cycle and it will work fine until the next hang. I
> upgraded to 2.4.2-ac11 because of the documented tulip fixes, but after a
> few days got this again. The error log shows:

In Alan Cox terms, that's a long time ago :)

Can you please try 2.4.2-ac20?  It includes fixes specifically for this
problem.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
