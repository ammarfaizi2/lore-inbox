Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278736AbRJZQQg>; Fri, 26 Oct 2001 12:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278746AbRJZQQ0>; Fri, 26 Oct 2001 12:16:26 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:47116 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S278736AbRJZQQI>;
	Fri, 26 Oct 2001 12:16:08 -0400
Message-ID: <3BD98991.C5D3B7A1@nyc.rr.com>
Date: Fri, 26 Oct 2001 12:04:33 -0400
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <laughing@shared-source.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac1
In-Reply-To: <fa.kgfmokv.12jgvrv@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where is ac7 ?

Alan Cox wrote:
> 
> 2.4.13-ac1
> o       Merge with Linus 2.4.13
> 
> 2.4.12-ac7
> o       Fix i2o_proc locking thinko                     (me)
> o       Aiptek tablet driver                            (Chris Atenasio)
> o       Update ARM920T support                          (Russell King)
> o       Add some additional PCI idents                  (Tim Hockin)
> o       Further SA1100/CERF ARM updates                 (Russell King)
> o       Reduce printk noise in amd flash driver         (David Woodhouse)
> o       Add missing schedule() to jffs2 gc thread       (David Woodhouse)
> o       Add license tag to NTFS                         (Richard Russon)
> o       PCMCIA suspend fix for SA1100 ARM               (Russell King)
> o       Increase close wait tracking for ip_conntrack   (Darrell Escola)
> o       PCI hot plug support                            (Greg Kroah-Hartmann)
> o       Compaq FC driver update                         (Steve Cameron)
> o       Fix UP APIC without IOAPIC build fail           (Mikael Pettersson)
> o       Intel 82092 PCI/PCMCIA bridge support           (Arjan van de Ven)
>         | Based heavily on the pcmcia package
> o       Include buffer size extension in dhcp frames    (Andreas Steinmetz)
> o       Fix u14f/u34f build problem                     (Andreas Steinmetz)
> o       Fix trident.c build on Alpha                    (me)
> o       Various other Alpha build fixes                 (Jeff Garzik)
> o       Simplify serverworks mtrr check                 (Dave Jones)
> o       ARM configuration updates                       (Russell King)
> o       Update natsemi driver                           (Jeff Garzik)
> o       Computone ip2 update                            (Michael Warfield)
> o       Fix CONFIG_SIMNOW                               (Andi Kleen)
> o       Update 8139too docs                             (Jeff Garzik)
> o       Make autofs4 return symlink lengths
