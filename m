Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270432AbTHQQ5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270436AbTHQQ5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:57:39 -0400
Received: from alfa.fastwebnet.it ([213.140.2.42]:4091 "EHLO
	alfa.fastwebnet.it") by vger.kernel.org with ESMTP id S270432AbTHQQ5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:57:38 -0400
Subject: vfat lost file problem
From: Raistlin <raistlin83@libero.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1061139456.808.5.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 17 Aug 2003 18:57:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Version:
Linux debian 2.4.21 #6 SMP Wed Aug 6 11:55:01 CEST 2003 i686 GNU/Linux
mv command Version:
mv (coreutils) 5.0.90


I've discovered that if you try to change the name of a file in a vfat
partition only changing upper or lower case the file immediatly
disappears.

Example:
If we have the file a.txt and we want to rename it like A.txt if we use
the mv command `mv a.txt A.txt` the file a.txt (and also A.txt) are
deleted.


I hope I helped you; let me know if it's so (i'm not subscribed to the
mailing list)
Bye 
Luigi Audasso - il_guru


