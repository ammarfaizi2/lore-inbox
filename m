Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSFXWiz>; Mon, 24 Jun 2002 18:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSFXWiy>; Mon, 24 Jun 2002 18:38:54 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:63485 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S315374AbSFXWiy>; Mon, 24 Jun 2002 18:38:54 -0400
Date: Mon, 24 Jun 2002 15:39:34 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.5.24-lsm1
Message-ID: <20020624153934.A17122@figure1.int.wirex.com>
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

2.5.24-lsm1 patch released.  This is just a simple rebase to 2.5.24.

Full lsm-2.5 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.5/2.5.24/patch-2.5.24-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.5/2.5.24/ChangeLog-2.5.24-lsm1

The LSM 2.5 BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.5

2.5.24-lsm1
 - merge with 2.5.24					(me)
 - removed unneeded cpqphp.h fix			(Greg KH)
 - document module identifier				(David Wheeler)

thanks,
-chris

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
