Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbSJDIiR>; Fri, 4 Oct 2002 04:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261533AbSJDIiR>; Fri, 4 Oct 2002 04:38:17 -0400
Received: from pop.gmx.net ([213.165.64.20]:61011 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261528AbSJDIiQ> convert rfc822-to-8bit;
	Fri, 4 Oct 2002 04:38:16 -0400
From: Michael Wahlbrink <linux.wali@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 - menuconfig crash
Date: Fri, 4 Oct 2002 10:41:50 +0200
User-Agent: KMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200210041041.50955.linux.wali@gmx.de>
X-Posting-Agent: Hamster/1.3.23.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
after the call of linus for giving the 2.5.40 a test I decided to make my 
first experiences with the new kernel series.
But I was'nt very lucky, the make menuconfig breaks when I try to enter the 
following entry:
sound -> Advanced Linux Sound Architecture -> 'crash'
The relevant part of the error is:
Q> ./scripts/Menuconfig: MCmenu74: command not found
I've no special hardware here and if you need more informations please ask ;-)
any hints how I can get the alsa stuff into the kernel?

regards
micha

ps: I hope it's all correct with this post, its my first mail to lkml...
