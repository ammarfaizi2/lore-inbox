Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRAOX3I>; Mon, 15 Jan 2001 18:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130549AbRAOX27>; Mon, 15 Jan 2001 18:28:59 -0500
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:48015 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S129835AbRAOX2r>; Mon, 15 Jan 2001 18:28:47 -0500
From: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 15 Jan 2001 23:31:29 +0000
Reply-To: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
X-Mailer: PMMail 1.96a For OS/2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Initio 9x00 SCSI driver status
Message-Id: <20010115232851Z129835-403+553@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing some work on the Initio 9100UW SCSI driver that is
distributed with 2.4.0. I've fixed a couple of bugs and added /proc
support to my copy of the source.

Is there an active maintainer of this driver at present? 

Is there anything that tells what to do to add support for the new
error handling code so it doesn't use scsi_old.c any more?

I'm reading this via fa.linux.kernel so should pick up replies that way
but email is fine too.


Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
