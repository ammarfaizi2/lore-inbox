Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318435AbSHVINJ>; Thu, 22 Aug 2002 04:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318487AbSHVINJ>; Thu, 22 Aug 2002 04:13:09 -0400
Received: from 213-84-203-196.adsl.xs4all.nl ([213.84.203.196]:16644 "EHLO
	gateway.cia.c64.org") by vger.kernel.org with ESMTP
	id <S318435AbSHVINI>; Thu, 22 Aug 2002 04:13:08 -0400
Date: Thu, 22 Aug 2002 10:12:13 +0200 (CEST)
From: Ben Castricum <benc@cia.c64.org>
To: linux-kernel@vger.kernel.org
Subject: {SPAM?} Linux 2.4.20-pre4 depmod errors in agpgart.o
Message-ID: <Pine.LNX.4.44.0208221009550.1022-100000@gateway.cia.c64.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: SpamAssassin (score=5.3, required 5, URI_IS_POUND,
	NORMAL_HTTP_TO_IP)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


root@gateway:/usr/src/linux# depmod -ae
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre4/kernel/drivers/char/agp/agpgart.o
depmod:         change_page_attr

My full config can be found at http://213.84.203.196/.config

Hope this helps,
Ben

