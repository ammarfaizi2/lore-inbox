Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbUBYNkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 08:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUBYNkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 08:40:31 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:45995 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261323AbUBYNk3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 08:40:29 -0500
Message-ID: <403CA5CC.5040207@namesys.com>
Date: Wed, 25 Feb 2004 16:40:28 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Latest Reiser4 Snapshot
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

new reiser4 snapshot against 2.6.3 kernel is available at

http://www.namesys.com/snapshots/2004.02.25

It contains bug fixes and stability improvements. On-disk format is
compatible with the previous snapshot. Also,

  * raid0 preliminary support, and

  * improved loop back support

were added.

In "standard" configuration reiser4 is stable except for a multiple umount/mount 
issue we are still analyzing. See the READ.ME file for not-well-supported 
features and options.

Hopefully our next snapshot will be ready for inclusion, and hopefully it is 
just a few days away.



