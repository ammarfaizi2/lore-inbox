Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268028AbUHPXze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268028AbUHPXze (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUHPXzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:55:33 -0400
Received: from outbound01.telus.net ([199.185.220.220]:128 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S268028AbUHPXzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 19:55:32 -0400
From: Shaun Jackman <sjackman@telus.net>
To: linux-kernel@vger.kernel.org
Subject: Hang after "BIOS data check successful" with DVI
Date: Mon, 16 Aug 2004 16:55:43 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408161655.43266.sjackman@telus.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I have a DVI display plugged into my Matrox G550 video card the
boot process hangs at "BIOS data check successful". I am running Linux
kernel 2.6.6. This problem does not affect Linux kernel 2.4.26. If I
boot without the DVI display plugged in, I can plug it in after the
boot process and the display works.

Please cc me in your reply. Thanks,
Shaun


