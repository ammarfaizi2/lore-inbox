Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283480AbRK3C7T>; Thu, 29 Nov 2001 21:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283488AbRK3C7J>; Thu, 29 Nov 2001 21:59:09 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:11079 "EHLO
	c0mailgw03.prontomail.com") by vger.kernel.org with ESMTP
	id <S283480AbRK3C6t>; Thu, 29 Nov 2001 21:58:49 -0500
Message-ID: <3C06F5C7.9D19E214@starband.net>
Date: Thu, 29 Nov 2001 21:58:15 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SYMBIOS BUG
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I sent in a full detailed bug report before, but everyone
ignored it.

Problem: IDE-SCSI (FOR CDRW DRIVES) + (SYMBIOS BOARD) cannot both
co-exist at the same time.

Reason: cd-burning does not work.

Anyone know why this is?

I have an adaptec in my box, + ide-scsi, and they co-exist fine?


