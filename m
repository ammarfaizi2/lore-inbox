Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272120AbTHBIgH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 04:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272141AbTHBIgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 04:36:07 -0400
Received: from cc68231-a.ensch1.ov.home.nl ([212.120.112.227]:61825 "EHLO
	namlook.thomas.planescape.com") by vger.kernel.org with ESMTP
	id S272120AbTHBIgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 04:36:06 -0400
From: Thomas Zander <zander@planescape.com>
To: linux-kernel@vger.kernel.org
Subject: bug in menuconfig (curses.h missing)
Date: Sat, 2 Aug 2003 10:33:22 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308021033.36343.zander@planescape.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got the message curses.h missing (scripts/lxdialog/dialog.h:29:20)
Followed by a 3 screens of other messages.

Would it be possible to detect this and print this in a pre-compile check?

Ok, I'm installing ncurses now :)
-- 
Thomas Zander

