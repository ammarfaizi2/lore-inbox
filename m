Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRKHML2>; Thu, 8 Nov 2001 07:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273269AbRKHMLS>; Thu, 8 Nov 2001 07:11:18 -0500
Received: from leeor.math.technion.ac.il ([132.68.115.2]:22446 "EHLO
	leeor.math.technion.ac.il") by vger.kernel.org with ESMTP
	id <S276369AbRKHMLJ>; Thu, 8 Nov 2001 07:11:09 -0500
Date: Thu, 8 Nov 2001 14:10:58 +0200 (IST)
From: "Zvi Har'El" <rl@math.technion.ac.il>
To: Arjan van de Ven <arjanv@redhat.com>
cc: <linux-kernel@vger.kernel.org>, "Nadav Har'El" <nyh@math.technion.ac.il>
Subject: Re: ext3 vs resiserfs vs xfs
In-Reply-To: <3BEA6725.739463C2@redhat.com>
Message-ID: <Pine.GSO.4.33.0111081407130.28492-100000@leeor.math.technion.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Arjan van de Ven wrote:

>
> The basic idea is "everything which can be a module will be a module",
> even scsi is a module. And if you use grub, it's 100% transparent as the
> initrd
> will be automatically added to the grub config when you install the RH
> kernel rpm;
> even if you use lilo the initrd is supposed to be made for you

Is there no overhead (except in boot time) in using initrd? If there is, and
ext3fs becomes the normative fs, IMHO ext3 should be part of the kernel, and
not an add-on.

Thanks,

Zvi.

-- 
Dr. Zvi Har'El     mailto:rl@math.technion.ac.il     Department of Mathematics
tel:+972-54-227607                   Technion - Israel Institute of Technology
fax:+972-4-8324654 http://www.math.technion.ac.il/~rl/     Haifa 32000, ISRAEL
"If you can't say somethin' nice, don't say nothin' at all." -- Thumper (1942)
                          Thursday, 22 Heshvan 5762,  8 November 2001,  2:07PM

