Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbRBXV4R>; Sat, 24 Feb 2001 16:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129637AbRBXVz7>; Sat, 24 Feb 2001 16:55:59 -0500
Received: from isunix.it.ilstu.edu ([138.87.124.103]:19475 "EHLO
	isunix.it.ilstu.edu") by vger.kernel.org with ESMTP
	id <S129636AbRBXVzz>; Sat, 24 Feb 2001 16:55:55 -0500
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <200102242145.PAA26761@isunix.it.ilstu.edu>
Subject: mtrr message
To: linux-kernel@vger.kernel.org
Date: Sat, 24 Feb 2001 15:45:37 -0600 (CST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm noticing these messages:

	mtrr: base(0xd4000000) is not aligned on a size(0x1800000) boundary

:many times in dmesg.  System is a dual P3-933 on a MSI 694D board (Apollo
Pro 133).

Is it worrisome?
