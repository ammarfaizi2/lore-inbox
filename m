Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbTBLLYa>; Wed, 12 Feb 2003 06:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbTBLLYa>; Wed, 12 Feb 2003 06:24:30 -0500
Received: from webmail27.rediffmail.com ([203.199.83.37]:33203 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S267029AbTBLLY3>;
	Wed, 12 Feb 2003 06:24:29 -0500
Date: 12 Feb 2003 11:39:45 -0000
Message-ID: <20030212113945.10014.qmail@webmail27.rediffmail.com>
MIME-Version: 1.0
From: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
Reply-To: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Building CRAMFS
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

We am trying to use CRAMFS for the target board which has
8 MB flash and 32 MB RAM.

I have few clarifications regarding CRAMFS.

1) Does CRAMFS requires initrd support?

2) From the net and few archival mails, i get to know that CRAMFS 
can
be built in 2 ways. One building with the kernel and the other 
one
creating the CRAMFS image and writing that image in to the 
flash.

3) Also if i wan to build with the kernel, whether the same 
procedure for ramdisk can be used? i.e. creating CRAMFS image, 
coverting it to
a object code format and copy it to src/linux/arch/mips/boot as 
ramdisk.o.

Thanks in advance,
Nanda

