Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbUCGWOz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 17:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbUCGWOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 17:14:54 -0500
Received: from law10-f22.law10.hotmail.com ([64.4.15.22]:56845 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262345AbUCGWOw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 17:14:52 -0500
X-Originating-IP: [67.22.169.122]
X-Originating-Email: [jpiszcz@hotmail.com]
From: "Justin Piszcz" <jpiszcz@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.3 CD Burning Problems, Looks Kernel Realted
Date: Sun, 07 Mar 2004 22:14:50 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F224x1h7AzQpq0004dd3c@hotmail.com>
X-OriginalArrivalTime: 07 Mar 2004 22:14:51.0874 (UTC) FILETIME=[9CAF9C20:01C40491]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not only cdrdao, but cdrecord as well only see's the SECOND IDE channel.
Why is this?

I have my main disk on a Promise board incase anyone wonders what that is 
(hde).

$ ./cdrecord dev=ATAPI --scanbus
Cdrecord-Clone 2.01a26 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg 
Schilling
scsidev: 'ATAPI'
devname: 'ATAPI'
scsibus: -2 target: -2 lun: -2
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
Using libscg version 'schily-0.7'.
scsibus0:
        0,0,0     0) 'PLEXTOR ' 'CD-R   PX-W1210A' '1.10' Removable CD-ROM
        0,1,0     1) 'TOSHIBA ' 'DVD-ROM SD-M1712' '1004' Removable CD-ROM
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

_________________________________________________________________
Store more e-mails with MSN Hotmail Extra Storage – 4 plans to choose from! 
http://click.atdmt.com/AVE/go/onm00200362ave/direct/01/

