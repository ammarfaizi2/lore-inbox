Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTETOYy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 10:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTETOYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 10:24:53 -0400
Received: from [203.94.130.164] ([203.94.130.164]:16774 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S263792AbTETOYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 10:24:52 -0400
Date: Wed, 21 May 2003 00:14:50 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: linux-kernel@vger.kernel.org
cc: jsimmons@infradead.org, <linux-fbdev-devel@lists.sourceforge.net>
Subject: CONFIG_VIDEO_SELECT stole my will to live
Message-ID: <Pine.LNX.4.44.0305210002210.19743-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

since 2.5.67-bk5. I have been unable to boot my laptop
tonight, I finally traced it back to

http://linux.bkbits.net:8080/linux-2.5/cset@1.1006

this changeset

more details on the problem can be found

http://bugzilla.mozilla.org/show_bug.cgi?id=677

there
and

http://bad-sports.com/~brett/bugreports/kernel/2.5.69-failboot/

there

the video card is a chips and tech 65545

i'd just like to know where to go from here, so that I can return to 
booting with CONFIG_VIDEO_SELECT set 

i'm not on fbdev-devel, so please just cc me to any response

thanks,

	/ Brett

