Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261361AbSJYKHi>; Fri, 25 Oct 2002 06:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261362AbSJYKHi>; Fri, 25 Oct 2002 06:07:38 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:16616 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S261361AbSJYKHh>; Fri, 25 Oct 2002 06:07:37 -0400
Date: Fri, 25 Oct 2002 11:15:04 +0100
From: Ian Leonard <ileonard@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: HPT372 on Abit KD7 motherboard
Message-ID: <20021025101504.GE13280@dino>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am trying to get the hpt372 ide to work (not as a raid).
I have tried 2.4.19 and with patch-2.4.20-pre11.

On boot, 'ide: lost interrupt' is printed, although the hpt372
is detected.  Partitions on ide can be mounted but soon
fail with busy errors.

I tried Highpoints Linux driver. This seems to work but
uses the scsi interface. Other messages in the archive
suggest that the 372 should work.

Anybody got this to work?

TIA.

--
Ian Leonard
eMail: ileonard@ntlworld.com
Phone: +44 (0)1865 765273

Please ignore spelling and punctuation - I did.
