Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbTGTQuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 12:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbTGTQuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 12:50:25 -0400
Received: from ws-han1.win-ip.dfn.de ([193.174.75.150]:37326 "EHLO
	ws-han1.win-ip.dfn.de") by vger.kernel.org with ESMTP
	id S267451AbTGTQuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 12:50:24 -0400
Date: Sun, 20 Jul 2003 19:05:23 +0200
Message-ID: <vines.sxdD+Gjg4zA@SZKOM.BFS.DE>
X-Priority: 3 (Normal)
To: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: problem linux-2.6.0-test1 on alpha
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,
 i have a problem with GNU linker for alpha. it crashes when
linking. ( I compiled with gcc 2.96.)
 
  LD      .tmp_vmlinux1
make: *** [.tmp_vmlinux1] Fehler 139

I have tried 2.12,2.13,2.14 sofar, no success at all. did anyone else tried 2.6 on alpha ?

walter

ps: i have alread reported this as a bug to binutils
