Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317858AbSHUFTO>; Wed, 21 Aug 2002 01:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317861AbSHUFTO>; Wed, 21 Aug 2002 01:19:14 -0400
Received: from smtpout.mac.com ([204.179.120.85]:53956 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S317858AbSHUFTN>;
	Wed, 21 Aug 2002 01:19:13 -0400
Date: Tue, 20 Aug 2002 22:23:10 -0700
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Info on OF Prom Calls
From: earendil <earendil@mac.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1502E5C8-B4C6-11D6-B4E5-0003938AE3BA@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on an embedded PowerPC project.  Since I rolled my own 
bootloader, I don't have the Open Firmware prom on my board.  I need to 
know what the kernel is expecting when it makes calls into the prom.  I 
assume it is looking into the device tree (which I have to figure out 
too) and maybe returning info.

Is there any documentation out there for what these calls are doing?  i 
am getting the IEEE doc for Open Firmware, but from what I have seen it 
is at a higher level, and I need the guts of the procedures.

