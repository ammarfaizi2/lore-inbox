Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAIEPn>; Mon, 8 Jan 2001 23:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAIEPd>; Mon, 8 Jan 2001 23:15:33 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:15878 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S129485AbRAIEP0>; Mon, 8 Jan 2001 23:15:26 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E95137@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Pavel Machek'" <pavel@suse.cz>, adefacc@tin.it,
        linux-kernel@vger.kernel.org
Subject: RE: Confirmation request about new 2.4.x. kernel limits
Date: Mon, 8 Jan 2001 23:11:05 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	> Max. RAM size:			64 GB	(any slowness
accessing RAM over 4 GB
*	with 32 bit machines ?)
	Imore than 4GB in RAM is bounce buffered, so there is performance
penalty as the data have to be copied into the 4GB RAM area
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
