Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbVIAWZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbVIAWZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbVIAWZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:25:13 -0400
Received: from mail.ncsa.uiuc.edu ([141.142.2.28]:24787 "EHLO
	mail.ncsa.uiuc.edu") by vger.kernel.org with ESMTP id S1030462AbVIAWZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:25:11 -0400
X-Envelope-From: gshi@ncsa.uiuc.edu
Message-Id: <5.1.0.14.2.20050901172329.03b58c68@pop.ncsa.uiuc.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 01 Sep 2005 17:25:08 -0500
To: linux-kernel@vger.kernel.org
From: Guochun Shi <gshi@ncsa.uiuc.edu>
Subject: 2.6.13-mm1 compiling error
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-NCSA-MailScanner-Information: Please contact the help@ncsa.uiuc.edu for more information
X-NCSA-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I tried to compile 2.6.13-mm1, got some error:

  CC [M]  drivers/isdn/i4l/isdn_tty.o
drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_try_read':
drivers/isdn/i4l/isdn_tty.c:71: error: structure has no member named `flip'
drivers/isdn/i4l/isdn_tty.c:86: error: structure has no member named `flip'
drivers/isdn/i4l/isdn_tty.c:86: error: structure has no member named `flip'
drivers/isdn/i4l/isdn_tty.c:88: error: structure has no member named `flip'


-Guochun

