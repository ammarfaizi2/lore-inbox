Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285193AbRL2SkT>; Sat, 29 Dec 2001 13:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285186AbRL2SkJ>; Sat, 29 Dec 2001 13:40:09 -0500
Received: from cc192618-b.oakrdg1.tn.home.com ([65.8.221.188]:7090 "EHLO
	rdb.linux-help.org") by vger.kernel.org with ESMTP
	id <S285193AbRL2Sj7>; Sat, 29 Dec 2001 13:39:59 -0500
Message-ID: <3C2E0E01.EE3D22D7@ardynet.com>
Date: Sat, 29 Dec 2001 13:40:01 -0500
From: rdicaire@ardynet.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AWE64 Duplex not working with 2.4.17
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have installed an SB AWE 64, kernel is 2.4.17, audio works fine, but I
cannot play
simultaneous multpile wav or mp3 files, errors reported that something
else has the device open already.

Here's what syslog reports when the modules are loaded:

Dec 29 13:21:13 ws kernel: Soundblaster audio driver Copyright (C) by
Hannu Savolainen 1993-1996 
Dec 29 13:21:14 ws kernel: sb: Creative SB AWE64  PnP detected 
Dec 29 13:21:14 ws kernel: sb: ISAPnP reports 'Creative SB AWE64  PnP'
at i/o 0x220, irq 5, dma 1, 5 
Dec 29 13:21:14 ws kernel: SB 4.16 detected OK (220) 
Dec 29 13:21:14 ws kernel: sb: 1 Soundblaster PnP card(s) found. 


Is there some module option to enable duplex operation?

Please CC: me on replies as I am not on this mailing list, thanks.
