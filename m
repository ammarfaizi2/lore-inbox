Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUAIPXg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUAIPXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:23:36 -0500
Received: from [212.239.224.221] ([212.239.224.221]:37252 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262123AbUAIPXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:23:13 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.4.18]: Reiserfs: vs-2120: add_save_link: insert_item returned -28
Date: Fri, 9 Jan 2004 16:22:41 +0100
User-Agent: KMail/1.5.4
Cc: reiserfs-list@namesys.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401091622.41352.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

Today I discovered I could no longer create files on one of my boxes, which 
still runs 2.4.18 (box is too far away to upgrade right now). It gives me 
'disk full' messages.

The following message is all over my logs since January 3:

vs-2120: add_save_link: insert_item returned -28

I can't seem to find much on this issue, is this a bug in reiserfs (which is 
fixed in a later version)? Is something wrong with the fs itself?

Thanks for answers.

[I'm not subscribed @ reiserfs-list, so please cc me with answers from that 
list]

Jan
-- 
It is exactly because a man cannot do a thing that he is a proper judge of it.
		-- Oscar Wilde

