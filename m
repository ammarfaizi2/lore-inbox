Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285047AbRLKPLR>; Tue, 11 Dec 2001 10:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285056AbRLKPK5>; Tue, 11 Dec 2001 10:10:57 -0500
Received: from web12308.mail.yahoo.com ([216.136.173.106]:5646 "HELO
	web12308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285047AbRLKPKv>; Tue, 11 Dec 2001 10:10:51 -0500
Message-ID: <20011211151050.12948.qmail@web12308.mail.yahoo.com>
Date: Tue, 11 Dec 2001 07:10:50 -0800 (PST)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: [PATCH] cciss 2.5.0 for 2.5.1-pre9
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch for the cciss driver in the 2.5.1-pre8 tree
(patch also applies to 2.5.1-pre9):

http://geocities.com/dotslashstar/cciss_2.5.0_for_2.5.1-pre8.txt

This patch:

* adds support for SCSI tape drives. 
* adds support for dynamically adding and removing      
  logical volumes on the fly.

I can't include this patch inline for a variety of reasons:
(it's too big, Mozilla pukes when I try to paste it into yahoo mail,
My Compaq MS mail account seems to insist on mangling whitespace, 
etc.  Sorry.)

Variants of this patch have been submitted before with little or 
no response.  Perhaps it's too big.  Perhaps it does 2 things,
and so is unacceptable.  Perhaps a hybrid scsi/block driver is
just too weird.  Perhaps it was just too weird and big for 2.4, but
maybe it's ok for 2.5.   In any case, here is the patch, rearing
its head again. :-)

Enjoy, and thanks.

-- steve


__________________________________________________
Do You Yahoo!?
Check out Yahoo! Shopping and Yahoo! Auctions for all of
your unique holiday gifts! Buy at http://shopping.yahoo.com
or bid at http://auctions.yahoo.com
