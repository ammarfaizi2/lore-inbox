Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264007AbTDWLrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 07:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbTDWLrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 07:47:39 -0400
Received: from mail.gmx.net ([213.165.65.60]:57971 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264007AbTDWLri convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 07:47:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Kirilenko <icedank@gmx.net>
Subject: Data storing
Date: Wed, 23 Apr 2003 14:59:37 +0300
User-Agent: KMail/1.4.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304231459.37955.icedank@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I need to make some checks (search for particular BIOS version) in the
very start of the kernel. I need to store this data (zero page is pretty good 
for this, I think) and access it from arch/i386/boot/setup.S, 
arch/i386/boot/compressed/misc.c and in some other places. Can somebody 
suggest me good place to put check procedure and how to pass data?

Best regards,
Andrew.

