Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbTBJWuV>; Mon, 10 Feb 2003 17:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbTBJWuV>; Mon, 10 Feb 2003 17:50:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:24712 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265477AbTBJWuU>;
	Mon, 10 Feb 2003 17:50:20 -0500
Subject: [KEXEC][2.5.60] Success Report
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1044918007.1705.22.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 10 Feb 2003 15:00:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same configuration of kexec that I have used successfully with
2.5.58 and 2.5.59 on my uniproc crash system also works when patched
into 2.5.60.

The current patch stack that I am using is now available in OSDL's patch
manager:

kexec base for 2.5.60 (based upon the version for 2.5.54):
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1467

kexec hwfixes that make it work for me (same as for 2.5.5[89]):
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1468

I have no new data to report on that oops sighting with kexec +
2.5.{59,60} on MP systems...

Andy


