Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVJDUaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVJDUaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVJDUaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:30:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17829 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964961AbVJDUaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:30:10 -0400
Date: Tue, 4 Oct 2005 21:30:09 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET] 2.6.14-rc3-git4-bird1
Message-ID: <20051004203009.GQ7992@ftp.linux.org.uk>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930120831.GI7992@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset againts 2.6.14-rc3-git4
 
 	* a pile of patches merged upstream
	* usual build regression fixes traffic.
	* ibmtr.c: bogus kfree() on some failure exits.
	* more UML makefiles cleanups (for post-2.6.14)
	* BFS: endianness annotations (Alexey) and killing iget() abuses (me).
 
Patch is on ftp.linux.org.uk/pub/people/viro/patch-2.6.14-rc3-git4-bird1.bz2,
splitup in ftp.linux.org.uk/pub/people/viro/patchset, logs (gcc and sparse)
in ftp.linux.org.uk/pub/people/viro/logs/*log24a

Current list of patches is in .../patchset/set*.
