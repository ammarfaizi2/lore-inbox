Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbTCFAGJ>; Wed, 5 Mar 2003 19:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbTCFAGJ>; Wed, 5 Mar 2003 19:06:09 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4817 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266965AbTCFAGI>;
	Wed, 5 Mar 2003 19:06:08 -0500
Subject: [KEXEC][2.5.64] kexec for 2.5.64 available
From: Andy Pfiffer <andyp@osdl.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: fastboot@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1046909807.29868.31.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 05 Mar 2003 16:16:47 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

I have a patch set available for kexec for 2.5.64.  I haved checked it
on a 1-way system, the 2-way test is pending an fsck of a partition that
was unfortunately eaten earlier today.

The patches are available for download from OSDL's patch lifecycle
manager (PLM):

Patch Stack for kexec for 2.5.64:

        kexec base for 2.5.64 (based upon 2.5.63 version)
        http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1656

        kexec hwfixes for 2.5.64 (based upon 2.5.63 version)
        http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1657

        kexec usemm change (allowed 2-way to previously work for me):
        http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1658

        optional change to defconfig to CONFIG_KEXEC=y
        http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1659

The patches are also available (with matching kexec-tools-1.8 --
unchanged from the 2.5.63 version) here:
http://www.osdl.org/archive/andyp/kexec/2.5.64/

Regards,
Andy


