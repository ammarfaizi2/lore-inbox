Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbTGUIAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 04:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268559AbTGUIAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 04:00:00 -0400
Received: from main.gmane.org ([80.91.224.249]:59051 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266169AbTGUH77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 03:59:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: andreas <a.baeurle@web.de>
Subject: XP vfat partitions
Date: Sun, 20 Jul 2003 17:27:03 +0200
Message-ID: <bfechu$tse$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My question is howto mount a Xp-vfat partition with 2.6 kernel.
In my fstab is following entry:
/dev/hda2       /windows/C      vfat    users,gid=users,umask=0002,iocharset=iso8859-1
code=437 0 0


