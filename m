Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbUJaPQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUJaPQY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 10:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbUJaPQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 10:16:24 -0500
Received: from [195.56.65.174] ([195.56.65.174]:39950 "EHLO h.kenyer.hu")
	by vger.kernel.org with ESMTP id S261273AbUJaPQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 10:16:22 -0500
Subject: Re: 2.6.10-rc1 crashes on recursive directory walk [2.6.9 was OK]
From: dap <dap@kenyer.hu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1099220254.677.6.camel@boxen>
References: <1099156115.14842.322.camel@localhost>
	 <1099220254.677.6.camel@boxen>
Content-Type: text/plain
Message-Id: <1099235773.14835.428.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 31 Oct 2004 16:16:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I also can't reproduce it under another box, so I compiled the -rc1
kernel again with same config and I'm trying to crash the produtive
server with that, but seems like I can't.
 I'm confused, maybe this problem was caused by some kind of compile
problem due to memory error, maybe just the ftp workload changed and
it's a hard to hit bug, don't know.. anyway, I use the -rc1 by now and
I'll report if this happened again.. sorry for the early report


On Sun, 2004-10-31 at 11:57, Alexander Nyberg wrote:
> .config & dmesg please, I can't seem to be able to reproduce this under
> me own environment. Also a little more description of how the setup
> looks like would be nice, I've only gathered one or more raid5 arrays
> with xfs and ext3 involved.


-- 
dap


