Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTKVPKA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 10:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTKVPKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 10:10:00 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:20484 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S262327AbTKVPJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 10:09:59 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200311221509.KAA07051@clem.clem-digital.net>
Subject: 2.6.0-test9-bk26 fails boot -- aic7890 detection
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sat, 22 Nov 2003 10:09:58 -0500 (EST)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test9-bk26 boot hangs after ide detection. Next detect normally
scsi AIC7XXX.  Has been good for all prior test9-bk's.
-- 
Pete Clements 
