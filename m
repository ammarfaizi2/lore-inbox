Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262555AbTCRV5R>; Tue, 18 Mar 2003 16:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262589AbTCRV5R>; Tue, 18 Mar 2003 16:57:17 -0500
Received: from air-2.osdl.org ([65.172.181.6]:63674 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262555AbTCRV5Q>;
	Tue, 18 Mar 2003 16:57:16 -0500
Subject: [KEXEC][2.5.65] kexec for 2.5.65 available
From: Andy Pfiffer <andyp@osdl.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: fastboot@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048025291.13196.7.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Mar 2003 14:08:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

I have a patch set available for kexec for 2.5.65.  I have checked it on
a 2-way system and it worked as expected.  There were no changes
required, and the previous version of kexec-tools worked without
modification.

The patches are available for download from OSDL's patch lifecycle
manager ( http://www.osdl.org/cgi-bin/plm/ ).

Patch stack for kexec for 2.5.65:

        kexec base for 2.5.65:
        http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1702

        kexec hwfixes for 2.5.65:
        http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1703

        kexec usemm change (allowed 2-way to work for me):
        http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1704

        optional change to defconfig (sets CONFIG_KEXEC=y):
        http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1705

The patches are also available (with matching kexec-tools-1.8) from this
link pending a crontab update:
http://www.osdl.org/archive/andyp/kexec/2.5.65/

Regards,
Andy


