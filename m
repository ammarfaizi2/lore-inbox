Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265931AbUHDODg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUHDODg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 10:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265947AbUHDODg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 10:03:36 -0400
Received: from s124.mittwaldmedien.de ([62.216.178.24]:62118 "EHLO
	s124.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S265931AbUHDODe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 10:03:34 -0400
Message-ID: <4110ECBF.9070000@vcd-berlin.de>
Date: Wed, 04 Aug 2004 16:03:43 +0200
From: Elmar Hinz <elmar.hinz@vcd-berlin.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Add support for IT8212 IDE controllers
References: <2obsK-5Ni-13@gated-at.bofh.it>
In-Reply-To: <2obsK-5Ni-13@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here some personel observations. Maybe they are result of little 
experience of mine. Maybe they are of use for others.

I use rev11 of it/ite8212 Dual Channel ATA RAID controller. On each 
master there is a 80GB harddisk.

When I set in the bios RAID 1 there comes an message similar
INVALID GEOMETRY: 0 PHYSICAL HEADS?
and booting stops.

When I set NORMAL, I get IRQ-timeouts for both disks. (IRQ 10)

but booting continous and I can use the disks.

hdparm => 15.70 MB/sec

Elmar








