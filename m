Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbTAOTe3>; Wed, 15 Jan 2003 14:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbTAOTe3>; Wed, 15 Jan 2003 14:34:29 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5859 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267244AbTAOTe2>;
	Wed, 15 Jan 2003 14:34:28 -0500
Subject: [2.5.58][KEXEC] Success! (using 2.5.54 version + kexec tools 1.8)
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       suparna@in.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Werner Almesberger <wa@almesberger.net>
In-Reply-To: <m1fzs6j0bh.fsf_-_@frodo.biederman.org>
References: <m1smwql3av.fsf@frodo.biederman.org>
	<20021231200519.A2110@in.ibm.com> <m11y3uldt9.fsf@frodo.biederman.org>
	<20030103181100.A10924@in.ibm.com>  <m1fzs6j0bh.fsf_-_@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 Jan 2003 11:43:40 -0800
Message-Id: <1042659820.14925.75.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

Success!

I've been carrying your kexec for 2.5.54 patch (and the hwfixes patch)
forward through subsequent kernels, and have had good luck (kexec works
fine for me) with them in 2.5.58 on my troublesome system (UP, P3-800,
640MB, Adaptec AIC7XXX SCSI).

I haven't had to change a thing with kexec.  For reference, the code I'm
currently using is downloadable from OSDL's patch-manager:

The "kexec-hwfixes" for to 2.5.58:
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1432

kexec patch for 2.5.58 (from the 2.5.54 version):
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1424

Regards,
Andy


