Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315982AbSENSfa>; Tue, 14 May 2002 14:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315983AbSENSf3>; Tue, 14 May 2002 14:35:29 -0400
Received: from a217-118-40-108.bluecom.no ([217.118.40.108]:10003 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S315982AbSENSf3>; Tue, 14 May 2002 14:35:29 -0400
Message-ID: <00fd01c1fb76$1d8654a0$0d01a8c0@studio2pw0bzm4>
From: "Dead2" <dead2@circlestorm.org>
To: "Tigran Aivazian" <tigran@veritas.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0205141920420.1577-100000@einstein.homenet>
Subject: Re: Initrd or Cdrom as root
Date: Tue, 14 May 2002 20:35:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect that whatever is he using for creating the images (what is this
> "isolinux.cfg"?) has modified the boot command line and that is why it
> fails. It works fine for me (and worked since the time I wrote it around
> 2.4.0 or so).

Isolinux: http://syslinux.zytor.com/iso.php

If you have a tutorial of how to make a bootable cdrom that does not use
Isolinux, then please point me to it.. =)

To make the iso image I use the following command:

'mkisofs -b isolinux.bin -o test.iso -no-emul-boot -boot-load-size
4 -boot-info-table /iso'

-=Dead2=-

