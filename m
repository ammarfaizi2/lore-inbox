Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbUBYRN6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUBYRN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:13:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:10972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261445AbUBYRNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:13:54 -0500
From: john cherry <cherry@osdl.org>
Date: Wed, 25 Feb 2004 09:13:51 -0800
Message-Id: <200402251713.i1PHDp700580@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.3 - 2004-02-24.17.30) - 6 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/aacraid/rkt.c:335: warning: `aac_rkt_check_health' defined but not used
drivers/scsi/aacraid/rx.c:335: warning: `aac_rx_check_health' defined but not used
drivers/scsi/aacraid/sa.c:310: warning: `aac_sa_check_health' defined but not used
{standard input}:4042: Warning: This is the location of the conflicting usage
{standard input}:4054: Warning: Only the first path encountering the conflict is reported
{standard input}:4054: Warning: Use of 'cmp4.eq' violates WAW dependency 'PR%, % in 1 - 15' (impliedf), specific resource number is 14
