Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315528AbSFEQk4>; Wed, 5 Jun 2002 12:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSFEQky>; Wed, 5 Jun 2002 12:40:54 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:20465 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S315528AbSFEQks>; Wed, 5 Jun 2002 12:40:48 -0400
Date: Wed, 5 Jun 2002 09:40:01 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.5.20-lsm1
Message-ID: <20020605094001.A21990@figure1.int.wirex.com>
Mail-Followup-To: linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Security Modules project provides a lightweight, general
purpose framework for access control.  The LSM interface enables
security policies to be developed as loadable kernel modules.
See http://lsm.immunix.org for more information.

2.5.20-lsm1 patch released.

Full lsm-2.5 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.5/2.5.20/patch-2.5.20-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.5/2.5.20/ChangeLog-2.5.20-lsm1


2.5.20-lsm1
 - merge with 2.5.20					(me)
 - SELinux enhanced MLS support				(Stphen Smalley)

2.5.19-lsm1
 - merge up through 2.5.19				(Greg KH/me)
 - more build cleanups					(Greg KH)
 - bring back quotactl hook				(Greg KH)
 - remove revalidate hook and update to getattr hook	(me)
 - SELinux updates					(Stephen Smalley)
   - fix quotactl hook
   - make extened socket call processing optional
   - Makefile cleanup
 - LIDS shellcode protection				(Huagang Xie)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
