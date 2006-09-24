Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWIXI5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWIXI5S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 04:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWIXI5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 04:57:18 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:42206 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751812AbWIXI5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 04:57:17 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
To: LKML <linux-kernel@vger.kernel.org>
Subject: New section mismatch warning on latest linux-2.6 git tree
Date: Sun, 24 Sep 2006 11:57:35 +0300
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609241157.36347.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This seems to be pretty new :

WARNING: arch/i386/kernel/cpu/cpufreq/speedstep-centrino.o - Section mismatch: 
reference to .init.text: from .data between 'sw_any_bug_dmi_table' (at offset 
0x320) and 'centrino_attr'

Using Linus' latest git tree.

Regards,
ismail
-- 
They that can give up essential liberty to obtain a little temporary safety 
deserve neither liberty nor safety.
-- Benjamin Franklin
