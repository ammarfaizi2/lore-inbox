Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263828AbRFDCHh>; Sun, 3 Jun 2001 22:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263832AbRFDCH1>; Sun, 3 Jun 2001 22:07:27 -0400
Received: from mail.coiinc.com ([207.40.103.90]:47118 "EHLO mail.coiinc.com")
	by vger.kernel.org with ESMTP id <S263828AbRFDCHW>;
	Sun, 3 Jun 2001 22:07:22 -0400
Date: Sun, 3 Jun 2001 20:08:25 -0500
From: Jerry Frana <franaj@coiinc.com>
Message-Id: <200106040108.f5418D823560@mail.coiinc.com>
Subject: USB-storage and 2.4.2
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, i've been having a problem with my usb zip drive (older 100mb model)

it's 100% repeateble: 

copy a large file to anywhere, and within a minute or so: 
copy stops dead.
and the following appears in the syslog:

Jun  3 21:10:56 int-21h kernel: uhci: host controller process error. something bad happened
Jun  3 21:10:56 int-21h kernel: uhci: host controller halted. very bad

my machine is a K6-3/350, kernel 2.4.2, via mvp3 chipset

if you need any more info, please let me know,

Thanks
David F.
