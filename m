Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSKEQ57>; Tue, 5 Nov 2002 11:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbSKEQ56>; Tue, 5 Nov 2002 11:57:58 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:41623 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S264938AbSKEQ55>;
	Tue, 5 Nov 2002 11:57:57 -0500
Date: Tue, 5 Nov 2002 12:04:32 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: usb massstorage thinks it's RO?]
Message-ID: <20021105170432.GO26964@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Just put my usb flash card in my machine at work.  I had the switch
set to RO but need to update some files.  Removed the device, flipped
the switch to RW mode and re-inserted.  

SCSI device sda: 64512 512-byte hdwr sectors (33 MB)
sda: Write Protect is on

Is something cached?  USB is compiled into the kernel, no modules.
Anyway to clear this short of a reboot?



:wq!
---------------------------------------------------------------------------
Robert L. Harris                
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'


