Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287841AbSBRVlE>; Mon, 18 Feb 2002 16:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSBRVky>; Mon, 18 Feb 2002 16:40:54 -0500
Received: from 162-39.84.64.covalent.net ([64.84.39.162]:44718 "EHLO
	doom.sfo.covalent.net") by vger.kernel.org with ESMTP
	id <S287841AbSBRVkp>; Mon, 18 Feb 2002 16:40:45 -0500
Date: Mon, 18 Feb 2002 13:40:41 -0800
From: john <john@zlilo.com>
To: linux-kernel@vger.kernel.org
Subject: kupdated using all CPU
Message-ID: <20020218134041.A2586@doom.sfo.covalent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Linux: http://zlilo.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
ive searched all over and found many references to this problem, but never found an actual solution.
the problem is that during heavy disk I/O, kupdated will periodically take up ALL the cpu.  like the mouse will stop responding, nothing moves.  the system is frozen until its done doing whatever its doing.
the problem is mostly evident on large file transfers or doing something like copying a large file or untarring a large tarball, etc.
i am running 2.4.17 on an IBM R30 thinkpad.  problem occurs on 2.4.16 also.

so is there already an answer about this that i just cant find?
any help appreciated, thanks.
-j
