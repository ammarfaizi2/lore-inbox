Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131772AbRBWTOp>; Fri, 23 Feb 2001 14:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131792AbRBWTOf>; Fri, 23 Feb 2001 14:14:35 -0500
Received: from web1305.mail.yahoo.com ([128.11.23.155]:42766 "HELO
	web1305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131772AbRBWTOQ>; Fri, 23 Feb 2001 14:14:16 -0500
Message-ID: <20010223191415.5746.qmail@web1305.mail.yahoo.com>
Date: Fri, 23 Feb 2001 11:14:15 -0800 (PST)
From: Tim Tim <timikpoket@yahoo.com>
Subject: problem with mount -o loop
To: linux-kernel@vger.kernel.org
In-Reply-To: <20000101004302.A45@(none)>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made iso-image from cd with 
  dd if=/dev/hdd of=/image.iso
and mount it with
  mount -o loop /image.iso /mnt/cdrom
under Linux-2.4.2-pre1 it is working
but under Linux-2.4.2 do not
Please help me to understand why



__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices! http://auctions.yahoo.com/
