Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265176AbVBEBzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbVBEBzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263954AbVBEBzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:55:54 -0500
Received: from web26503.mail.ukl.yahoo.com ([217.146.176.40]:51589 "HELO
	web26503.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264032AbVBEBvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 20:51:47 -0500
Message-ID: <20050205015146.11761.qmail@web26503.mail.ukl.yahoo.com>
Date: Sat, 5 Feb 2005 01:51:46 +0000 (GMT)
From: Neil Conway <nconway_kernel@yahoo.co.uk>
Subject: Re: 3TB disk hassles
To: "Pedro Venda \(SYSADM\)" <pjvenda@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41C21A1A.7010606@rnl.ist.utl.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy...

--- "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt> wrote:
> Neil Conway wrote:
> > Howdy...
> > After much banging of heads on walls, I am throwing in the towel
> and
> > asking the experts ;-) ... To cut a long story short:
> > Is it possible to make a 3TB disk work properly in Linux?
> > Our "disk" is 12x300GB in RAID5 (with 1 hot-spare) on a 3ware
> 9500-S12,
> > so it's actually 2.7TiB ish.  It's also /dev/sda - i.e., the one
> and
> > only disk in the system.
> 
> not meaning to criticise... but isn't it a good idea to have a
> separate raid1 volume to boot the system?

Well, yes, and we would if we could.  Sadly, the chassis we got from
our vendor only has space for the 12 hot-swap disks, and we need the
capacity too badly to lose 2 slots for a boot volume.  If only we could
take a sliver of each of the 12 disks to make a tiny RAID5 boot
volume...

Regards,
Neil


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Easier than ever with enhanced search. Learn more.
http://info.mail.yahoo.com/mail_250
