Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTFEGej (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 02:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTFEGej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 02:34:39 -0400
Received: from web8102.mail.in.yahoo.com ([203.199.70.29]:30256 "HELO
	web8102.in.yahoo.com") by vger.kernel.org with SMTP id S264450AbTFEGei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 02:34:38 -0400
Message-ID: <20030605064806.28607.qmail@web8102.in.yahoo.com>
Date: Thu, 5 Jun 2003 07:48:06 +0100 (BST)
From: =?iso-8859-1?q?maha=20rajan?= <maha_rtlin@yahoo.co.in>
Subject: Kernel Compilation errors .
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
  When i am trying to compile kernel 2.4.7-10 or 2.4.4
i get the error messages mentioned below. I am running
kernel 2.4.20-8 and my gcc is gcc - 3.2.2. What may be
the possible problems.

error messages :
devlist.h:6918: __devices_ca50 causes a section type
conflict
devlist.h:6921: __devices_cafe causes a section type
conflict
devlist.h:6924: __devices_cccc causes a section type
conflict
devlist.h:6927: __devices_d4d4 causes a section type
conflict
devlist.h:6931: __devices_d84d causes a section type
conflict
devlist.h:6934: __devices_e000 causes a section type
conflict
devlist.h:6938: __devices_e159 causes a section type
conflict
devlist.h:6942: __devices_e4bf causes a section type
conflict
devlist.h:6945: __devices_ea01 causes a section type
conflict
devlist.h:6948: __devices_eabb causes a section type
conflict
devlist.h:6951: __devices_ecc0 causes a section type
conflict
devlist.h:6954: __devices_edd8 causes a section type
conflict
devlist.h:6961: __devices_fa57 causes a section type
conflict
devlist.h:6964: __devices_feda causes a section type
conflict
devlist.h:6967: __devices_fffe causes a section type
conflict
devlist.h:6971: __devices_ffff causes a section type
conflict
make[3]: *** [names.o] Error 1
make[3]: Leaving directory
`/usr/src2.4/linux/drivers/pci'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory
`/usr/src2.4/linux/drivers/pci'
make[1]: *** [_subdir_pci] Error 2
make[1]: Leaving directory `/usr/src2.4/linux/drivers'
make: *** [_dir_drivers] Error 2


________________________________________________________________________
Missed your favourite TV serial last night? Try the new, Yahoo! TV.
       visit http://in.tv.yahoo.com
