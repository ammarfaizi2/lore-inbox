Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270143AbTGMHTP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 03:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270144AbTGMHSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 03:18:45 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:40716 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S270143AbTGMHSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 03:18:42 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.5 and devfs versioning
Date: Sun, 13 Jul 2003 11:32:46 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307131132.46522.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

{pts/2}% dmesg | head -1
Linux version 2.5.75-1borsmp ...

{pts/2}% dmesg | grep devfs
Kernel command line: BOOT_IMAGE=2575-1borsmp ro root=345 devfs=mount
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)

well, this is not quite correct to put it mildly. It has been so much changed 
that IMHO it needs own version just to avoid confusion.

-andrey
