Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTFORfp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTFORfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:35:45 -0400
Received: from mailgate.mailbox.co.za ([66.18.76.9]:60344 "EHLO
	mailgate.mailbox.co.za") by vger.kernel.org with ESMTP
	id S262444AbTFORfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:35:44 -0400
Message-Id: <200306151749.h5FHnL6k031625@mailgate.mailbox.co.za>
Date: Sun, 15 Jun 2003 19:49:21 +0200
From: "Koei Kaas" <kaas@mailbox.co.za>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
X-Mailer: WebMail v2.5.6-3
X-Sender-Ip: 152.106.240.10
X-Account: 275544
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re:Linux 2.4.21-ac1 - sparc64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.21-ac1 doesn't compile on sparc64. Some changes in
include/asm-sparc64 and arch/sparc64/kernel got me past the first few
errors. Some issues with current struct etc, that applied for other
archs isn't there for sparc64.

2.4.21 vanilla compiled fine.

_______________________________________________________________________
LOOK GOOD, FEEL GOOD - WWW.HEALTHIEST.CO.ZA

Cool Connection, Cool Price, Internet Access for R59 monthly @ WebMail
http://www.webmail.co.za/dialup/
