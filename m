Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131629AbRAaJRf>; Wed, 31 Jan 2001 04:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131636AbRAaJRZ>; Wed, 31 Jan 2001 04:17:25 -0500
Received: from mail15.bigmailbox.com ([209.132.220.46]:15122 "EHLO
	mail15.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S131629AbRAaJRF>; Wed, 31 Jan 2001 04:17:05 -0500
Date: Wed, 31 Jan 2001 01:16:27 -0800
Message-Id: <200101310916.BAA30755@mail15.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [24.5.157.48]
From: "Quim K Holland" <qkholland@my-deja.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: RAID1/RAID5 hot-add/hot-remove patch?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.

On the same topic; I am also wondering if there is a reason
why your RAID1/RAID5 hot-add/hot-remove patch (originally against
2.4.0-ac9, Message-ID: <Pine.LNX.4.30.0101151248200.1398-200000@e2>)
does not go into Linus tree.  

I saw Neil Brown commenting on the patch in linux-raid list in
<http://marc.theaimsgroup.com/?l=linux-raid&m=98028199906903&w=2>
(he was suggesting to revert it for somebody who had raid related
crashes), but do not know what happened after that discussion.
Alan Cox still seems to have the hot-add/hot-remove patch in his
tree as of 2.4.0-ac12.


------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
