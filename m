Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264672AbUEFBGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbUEFBGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 21:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264735AbUEFBGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 21:06:37 -0400
Received: from build.arklinux.oregonstate.edu ([128.193.0.51]:46808 "EHLO
	test.arklinux.org") by vger.kernel.org with ESMTP id S264672AbUEFBGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 21:06:36 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: linux-kernel@vger.kernel.org
Subject: 2.4.27-pre2-pac1
Date: Thu, 6 May 2004 03:01:07 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405060301.07841.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... is released, and can be downloaded from
ftp://ftp.<yourcountry>.kernel.org/pub/linux/kernel/people/bero/2.4/2.4.27/

Changes:
- Port to current kernel
- Make it build [and work] with gcc 3.4 (Based on Mikael Pettersson's patch 
for stock 2.4.27-pre2)
- Fix SATA harddisk detection on SiS controllers (Uwe Koziolek)
