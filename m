Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315546AbSFERWo>; Wed, 5 Jun 2002 13:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSFERWn>; Wed, 5 Jun 2002 13:22:43 -0400
Received: from web20808.mail.yahoo.com ([216.136.226.197]:2822 "HELO
	web20808.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315546AbSFERWk>; Wed, 5 Jun 2002 13:22:40 -0400
Message-ID: <20020605172240.17081.qmail@web20808.mail.yahoo.com>
Date: Wed, 5 Jun 2002 10:22:40 -0700 (PDT)
From: Shane Walton <dsrelist@yahoo.com>
Subject: Stream Lined Booting - SCSI Hold Up
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

I work with US DoD systems, and one of my requirements
is to boot an ix86 based system with an aic7xxx SCSI
interface in 15 seconds.  One of the apparent problems
is the SCSI BIOS and aic7xxx driver take a long time
to find one drive and then probe other empty channels.
 Is there a way to inform the aic7xxx driver of
connected hardware to limit the initialization phase? 
Thanks for the help.

Regards,

=====
Shane M. Walton, Software Engineer
Digital System Resources, Inc.
dsrelist@yahoo.com : swalton@dsrnet.com
703.234.1674

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
