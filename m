Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262988AbTC1ORB>; Fri, 28 Mar 2003 09:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262989AbTC1ORB>; Fri, 28 Mar 2003 09:17:01 -0500
Received: from WARSL401PIP5.highway.telekom.at ([195.3.96.90]:12840 "HELO
	email04.aon.at") by vger.kernel.org with SMTP id <S262988AbTC1ORB>;
	Fri, 28 Mar 2003 09:17:01 -0500
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: CD-Burning -> Kernel (warning?): __alloc_pages
Date: Fri, 28 Mar 2003 15:27:03 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303281527.03975.dusty@violin.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Everytime I write a CDRom, I get several errors like this in my messages-file, 
but the kernel does not panic/crash/freeze:

kernel: __alloc_pages: 3-order allocation failed (gfp=0x20/0)
kernel: __alloc_pages: 2-order allocation failed (gfp=0x20/0)

My Kernel version is 2.4.19-4GB (From SuSE 8.1) and I use a Ricoh RW9200 
IDE-CD writer with the ide-scsi interface and xcdroast (cdrecord). I have a 
AMD 751 (Irongate) chipset. If you need any more information, please tell me.

I want to know what this message means and if this is something to worry 
about. My written CD's seem to be o.k.

		Best Regards,
		Hermann

-- 
x1@aon.at
GPG key ID: 299893C7 (on keyservers)
FP: 0124 2584 8809 EF2A DBF9  4902 64B4 D16B 2998 93C7

