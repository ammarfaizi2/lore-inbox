Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265079AbRFUSIX>; Thu, 21 Jun 2001 14:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265078AbRFUSIN>; Thu, 21 Jun 2001 14:08:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8723 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265077AbRFUSH7>; Thu, 21 Jun 2001 14:07:59 -0400
Subject: Re: Linux 2.4.5-ac17
To: craig@webtelecoms.co.za (Craig Schlenter)
Date: Thu, 21 Jun 2001 19:06:40 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <20010621194748.C20240@webtelecoms.co.za> from "Craig Schlenter" at Jun 21, 2001 07:47:48 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15D8qm-0001qG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> between your tree and Linus' please? I haven't seen any ac stuff being
> spooled into Linus' tree for a while and the trees seem to be drifting
> further apart ... it would be nice if there wasn't much difference
> other than the device name and the page cache VFS stuff. I know you're
> both hectically busy but it would be nice to know that the plan is not
> to let things drift too far apart.

At the moment I'm not merging Linus stuff and resynchronizing because of
all the reports of strange ac14/15 crashes. If I merge the ext2 in pagecache
stuff it will get very hard to find.

Be assured my intention is to merge or discard everything in the -ac tree.

