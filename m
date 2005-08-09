Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbVHIVtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVHIVtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVHIVtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:49:17 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:9123 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964914AbVHIVtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:49:16 -0400
Subject: Re: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Fieroch <fieroch@web.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Michael Thonke <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Natalie.Protasevich@unisys.com, Andrew Morton <akpm@osdl.org>,
       Parag Warudkar <kaernel-stuff@comcast.net>
In-Reply-To: <42F8E7B9.403@web.de>
References: <d6gf8j$jnb$1@sea.gmane.org> <42EAAFD4.4010303@web.de>
	 <42EAD086.4010904@gmail.com> <200507291905.37339.kernel-stuff@comcast.net>
	 <20050730014237.GA20131@mipter.zuzino.mipt.ru>	 <42EE33F6.6040606@web.de>
	 <m3oe8h7978.fsf@defiant.localdomain>
	 <58cb370e050801122831a97873@mail.gmail.com>  <42F8E7B9.403@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Aug 2005 23:14:07 +0100
Message-Id: <1123625647.19543.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-09 at 19:28 +0200, Alexander Fieroch wrote:
> Andrew Morton wrote:
> > Please check 2.6.13-rc6 when it's out - this might fix the IRQ problem.
> 
> The errors "irq XXX: nobody cared" and "hdb: cdrom_pc_intr: The drive
> appears confused (ireason = 0x01)"  still occur in kernel 2.6.13rc6-git1.

Please stock cc'ing me about this. I'm nothing to do with the ACPI IRQ
routing code or your BIOS and these are not IDE bugs

Thanks
Alan

