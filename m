Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLKJoi>; Mon, 11 Dec 2000 04:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLKJo2>; Mon, 11 Dec 2000 04:44:28 -0500
Received: from rmx602-mta.mail.com ([165.251.48.51]:53419 "EHLO
	rmx602-mta.mail.com") by vger.kernel.org with ESMTP
	id <S129183AbQLKJoT>; Mon, 11 Dec 2000 04:44:19 -0500
Message-ID: <389221443.976526021983.JavaMail.root@web114-wra.mail.com>
Date: Mon, 11 Dec 2000 04:13:41 -0500 (EST)
From: Frank Davis <fdavis112@juno.com>
To: Bill Maidment <bill@maidment.com.au>
Subject: Re: Trouble with 2.4.0-test12-pre8
CC: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.242.214
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 > There is also a problem building fs/smbfs/inode.c at line 166
> 
> Is there a fix or have I got something really screwed up?

If you are referring to 'next' is not a member of the structure? If so, known issue.

Regards,
-Frank


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
