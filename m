Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAESou>; Fri, 5 Jan 2001 13:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132151AbRAESok>; Fri, 5 Jan 2001 13:44:40 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18439 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129387AbRAESoU>; Fri, 5 Jan 2001 13:44:20 -0500
Subject: Re: reiserfs patch for 2.4.0-final
To: mlist@intergrafix.net (Admin Mailing Lists)
Date: Fri, 5 Jan 2001 18:44:31 +0000 (GMT)
Cc: riel@conectiva.com.br (Rik van Riel), chris@scary.beasts.org (Chris Evans),
        mason@suse.com (Chris Mason), reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101051243200.323-100000@athena.intergrafix.net> from "Admin Mailing Lists" at Jan 05, 2001 12:45:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ebqr-0008E5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is ext2 upgradable to reiserfs or ext3?

You can live up and downgrade between ext2 and ext3. For ext2->reiser and back
you need to backup/restore or use a new partition currently - unless someone
has tools I've not seen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
