Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbQLKTVO>; Mon, 11 Dec 2000 14:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbQLKTVD>; Mon, 11 Dec 2000 14:21:03 -0500
Received: from mercury.nildram.co.uk ([195.112.4.37]:43013 "EHLO
	mercury.nildram.co.uk") by vger.kernel.org with ESMTP
	id <S129669AbQLKTUz>; Mon, 11 Dec 2000 14:20:55 -0500
Message-Id: <200012111850.eBBIoMl19836@mercury.nildram.co.uk>
From: "Per Jessen" <per@computer.org>
To: "Heiko.Carstens@de.ibm.com" <Heiko.Carstens@de.ibm.com>,
        "Matthew D. Pitts" <mpitts@suite224.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 11 Dec 2000 18:48:01 
Reply-To: "Per Jessen" <per@computer.org>
X-Mailer: PMMail 98 Professional (2.01.1600) For Windows 95 (4.0.1111)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: CPU attachent and detachment in a running Linux system
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko and Matthew -

I'm pretty certain this is not something beowulfish, unless perhaps 
you are thinking in terms of mosix and some of the other batch/queueing
systems. Beowulf after all is a set of distributed processors,
not SMP (although an individual node maybe SMP).

regards,
Per Jessen, London


On Mon, 11 Dec 2000 13:11:11 -0500, Matthew D. Pitts wrote:
>Heiko,
>If I'm not mistaken, this sort of thing has been done by the beowulf folks.
>
>Matthew D. Pitts
>mpitts@suite224.net
>
>----- Original Message ----- 
>From: <Heiko.Carstens@de.ibm.com>
>To: <linux-kernel@vger.kernel.org>
>Sent: Monday, December 11, 2000 9:03 AM
>Subject: CPU attachent and detachment in a running Linux system
[snip]


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
