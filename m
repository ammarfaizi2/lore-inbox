Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269036AbTGVT6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbTGVT6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:58:10 -0400
Received: from palrel10.hp.com ([156.153.255.245]:18363 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S269036AbTGVT6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:58:09 -0400
Date: Tue, 22 Jul 2003 13:13:12 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200307222013.h6MKDCwp010706@napali.hpl.hp.com>
To: dennis.miyoshi@hp.com, sam@ravnborg.org
Subject: RE: Build fails for ia64 with linux-2.6.0-test1-bk2 with missing file .
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F341E03C8ED6D311805E00902761278C0D2A2BE4@xfc04.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that Linus' tree at any given time may or may not work on ia64.
You'd probably be better off using the ia64 patch at:

  ftp://ftp.kernel.org/pub/linux/kernel/ports/ia64/v2.5/

Alternatively, if you want to try bleeding edge bits, you can pull from:

  bk://lia64.bkbits.net/linux-ia64-2.5/

	--david
