Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276271AbRJGKH1>; Sun, 7 Oct 2001 06:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276275AbRJGKHS>; Sun, 7 Oct 2001 06:07:18 -0400
Received: from maile.telia.com ([194.22.190.16]:30166 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S276271AbRJGKHI>;
	Sun, 7 Oct 2001 06:07:08 -0400
Date: Sun, 7 Oct 2001 12:02:08 +0200
From: acc <acc@acc.hn.org>
To: linux-kernel@vger.kernel.org
Subject: eepro100 net drivers
Message-Id: <20011007120208.5a426ef2.acc@acc.hn.org>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am using the eepro100 drivers for my network-card
and it makes my ethernet connection halting when I am
downloading big file, > ~1.5.

When the connection is halted I'll get this message
every second untill it works again:

eepro100: wait_for_cmd_done timeout!

I have noticed that I only have this problem when my X is
running. When my X is shutdown I dont have any problems.
I downloaded and tested the latest stable kernel 2.4.10, but
it still dont work.

I havn't found any solution for this problem, does anyone
known what the problem is ?

/Johan Nilsson
