Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273367AbRINMKv>; Fri, 14 Sep 2001 08:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273368AbRINMKl>; Fri, 14 Sep 2001 08:10:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7690 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273367AbRINMK1>; Fri, 14 Sep 2001 08:10:27 -0400
Subject: Re: v2410p8 and v2410p9 are no go
To: mozgy@hinet.hr (Mario Mikocevic)
Date: Fri, 14 Sep 2001 13:15:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010914134415.A802@danielle.hinet.hr> from "Mario Mikocevic" at Sep 14, 2001 01:44:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15hrsF-00006s-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernels 2.4.10-pre8 and 2.4.10-pre9 are NoGo for me,
> last kernel I tried and it still runs succesfully is 2.4.10-pre4.
> 
> dmesg difference is ->
> 
> - hda: [PTBL] [5171/240/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
> - hdd: [PTBL] [787/128/63] hdd1
> + hda: no partitions found
> + hdd: no partitions found
> 

What IDE chipset are you using.  Also do you have ACPI enabled and if so
does it work if you dont compile that in ?
