Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143934AbRAHPIJ>; Mon, 8 Jan 2001 10:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143953AbRAHPH7>; Mon, 8 Jan 2001 10:07:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18949 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143934AbRAHPHq>; Mon, 8 Jan 2001 10:07:46 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 8 Jan 2001 15:09:01 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0101080941430.4061-100000@weyl.math.psu.edu> from "Alexander Viro" at Jan 08, 2001 09:52:20 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Fduy-0004jm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which happens to be remarkably ugly. And it will not get better tomoorow...

Its really only ugly in one way which is that you pass an int for the item
rather than having a struct of all the data

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
