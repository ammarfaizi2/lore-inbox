Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278382AbRJWXb6>; Tue, 23 Oct 2001 19:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278381AbRJWXbs>; Tue, 23 Oct 2001 19:31:48 -0400
Received: from femail24.sdc1.sfba.home.com ([24.0.95.149]:17660 "EHLO
	femail24.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278376AbRJWXbj>; Tue, 23 Oct 2001 19:31:39 -0400
Message-ID: <3BD5FD1E.D4EB7649@home.com>
Date: Tue, 23 Oct 2001 19:28:30 -0400
From: John Gluck <jgluckca@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: OT: Problem compiling read_cdda-2.05
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Sorry for posting this here. I tried e-mailing the authir but the mail
got bounced.

I am trying to get this to compile.
I get the following errors:

In file included from read_cdda.c:71:
read_cdda.h:45: sys/cdio.h: No such file or directory
In file included from read_cdda.c:71:
read_cdda.h:50: sys/scsi/impl/uscsi.h: No such file or directory

I did a find on the file names and my system doesn't have them.

Is there a dependency I am unaware of??

I am using a 2.4.10 Linux kernel.

TIA

John



