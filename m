Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264611AbTFQGaP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 02:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264612AbTFQGaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 02:30:15 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:31734 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S264611AbTFQGaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 02:30:10 -0400
Date: Mon, 16 Jun 2003 23:43:16 -0700
From: Chris Wright <chris@wirex.com>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.72-lsm1
Message-ID: <20030616234316.B15655@figure1.int.wirex.com>
Mail-Followup-To: linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Security Modules project provides a lightweight, general purpose
framework for access control.  The LSM interface enables developing
security policies as loadable kernel modules.  See http://lsm.immunix.org
for more information.

Bah, just missed Linus releasing 2.5.72, so...2.5.72-lsm1 patch released.
This is just an update to 2.5.72.

Full lsm-2.5 patch (LSM + all modules) is available at:
	http://lsm.immunix.org/patches/2.5/2.5.72/patch-2.5.72-lsm1.gz

The whole ChangeLog for this release is at:
	http://lsm.immunix.org/patches/2.5/2.5.72/ChangeLog-2.5.72-lsm1

The LSM 2.5 BK tree can be pulled from:
        bk://lsm.bkbits.net/lsm-2.5

ChangeLog summary:

Chris Wright:
  o Merge patch-2.5.72 TAG: v2.5.72-lsm1

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
