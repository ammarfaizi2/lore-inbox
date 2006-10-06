Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWJFGns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWJFGns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 02:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbWJFGns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 02:43:48 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:30894 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932638AbWJFGnr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 02:43:47 -0400
Date: Fri, 6 Oct 2006 10:44:10 +0400
From: Vitaly Wool <vitalywool@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] UART driver for PNX8xxx
Message-Id: <20061006104410.618be6b1.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

this e-mail will be followed by two patches related to the UART driver for PNX8xxx MIPS platform.
The first one is a fixup for the serial header that fixes the compilation breakage for the very platform. The second one adds the UART driver functionality to the kernel. The driver itself is the one accepted by rmk in August but for some reason not included in the latest commits.

Vitaly
