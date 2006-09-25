Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751736AbWIYGCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbWIYGCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 02:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWIYGCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 02:02:38 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:31632 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932202AbWIYGCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 02:02:37 -0400
Date: Mon, 25 Sep 2006 07:59:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Petr Baudis <pasky@suse.cz>, David Schwartz <davids@webmaster.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: The GPL: No shelter for the Linux kernel?
In-Reply-To: <Pine.LNX.4.64.0609240923331.4388@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0609250757070.18552@yvahk01.tjqt.qr>
References: <MDEHLPKNGKAHNMBLJOLKIEJNOJAB.davids@webmaster.com>
 <Pine.LNX.4.61.0609231004330.9543@yvahk01.tjqt.qr> <Pine.LNX.4.64.0609231051570.4388@g5.osdl.org>
 <20060923181406.GC11916@pasky.or.cz> <Pine.LNX.4.61.0609240952240.28459@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0609240923331.4388@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Would every file that does not contain an explicit license (this 
>> excludes MODULE_LICENSE) falls under COPYING?
>
>[...]
>If a file doesn't have a license mentioned, it doesn't mean that it's 
>"free for all" or not copyrighted, it just means that you need to find out 
>what the license is some other way (and if you can't find out, you 
>shouldn't be copying that file ;)
>
>Of course, for clarity, a lot of projects end up adding at least a minimal 
>copyright header license everywhere, just to cover their *sses. It's not 
>required, but maybe it avoids some confusion, especially if that file is 
>later copied into some other project with other basic rules (but if you 
>do that, you really _should_ have added the information at that point!).
>[...]

Though I strongly agree with you, some GNU folks (such as 
savannah.nongnu.org) seem to explicitly require it, even for files 
that do not make up a single program (i.e. like coreutils/ls.c).



Jan Engelhardt
-- 
