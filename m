Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274746AbRJFJtB>; Sat, 6 Oct 2001 05:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274749AbRJFJsv>; Sat, 6 Oct 2001 05:48:51 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:17164 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274746AbRJFJsl>;
	Sat, 6 Oct 2001 05:48:41 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.11-pre4 mwave
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Oct 2001 19:48:59 +1000
Message-ID: <18719.1002361739@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.11-pre4 contains drivers/char/mwave.  No Config.in file selects
mwave, no higher level Makefile uses drivers/char/mwave/Makefile.
What gives?

