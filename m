Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267748AbSLGL00>; Sat, 7 Dec 2002 06:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267749AbSLGL00>; Sat, 7 Dec 2002 06:26:26 -0500
Received: from [81.2.122.30] ([81.2.122.30]:53764 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267748AbSLGL0Z>;
	Sat, 7 Dec 2002 06:26:25 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212071145.gB7BjTcE000914@darkstar.example.net>
Subject: Make menuconfig fails on small display in 2.5.50
To: linux-kernel@vger.kernel.org
Date: Sat, 7 Dec 2002 11:45:29 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried to run make menuconfig on 2.5.50, on a serial terminal,
and it reports:

Your display is too small to run Menuconfig!
It must be at least 19 lines by 80 columns.

make menuconfig in 2.4.20 works perfectly.

I'm pretty sure I've got the terminal configured correctly - has
anybody experienced this?

John
