Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSFXWoS>; Mon, 24 Jun 2002 18:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSFXWoR>; Mon, 24 Jun 2002 18:44:17 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:32240 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S315379AbSFXWoR>; Mon, 24 Jun 2002 18:44:17 -0400
Date: Mon, 24 Jun 2002 15:44:58 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] 2.4.19-rc1-lsm1
Message-ID: <20020624154458.A17165@figure1.int.wirex.com>
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

2.4.19-rc1 lsm patch released.  This is just a simple rebase to 2.4.19-rc1.

Full lsm-2.4 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.4/2.4.19/patch-2.4.19-rc1-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.4/2.4.19/ChangeLog-2.4.19-rc1-lsm1

The LSM 2.4 development BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.4-dev

2.4.19-rc1-lsm1
 - merge with 2.4.19-rc1				(me)
 - document module identifier				(David Wheeler)
 - whitespace cleanup					(Greg KH)

thanks,
-chris

-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
