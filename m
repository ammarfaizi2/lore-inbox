Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTLBGuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 01:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTLBGuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 01:50:52 -0500
Received: from defout.telus.net ([199.185.220.240]:18327 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S261217AbTLBGuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 01:50:51 -0500
Subject: Re: [PATCH] fix use-after-free in sbp2.c
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1070348018.2363.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Dec 2003 23:53:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! :)
 I applied your patch (by hand, but the patch is small) to
2.6.0-test11.  Its working fine here.  The debug/spinlock errors are
gone and all sbp2 devices show up in /proc/scsi/scsi.  


Cheers,
-- 
Bob Gill <gillb4@telusplanet.net>

