Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbTBBVDv>; Sun, 2 Feb 2003 16:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbTBBVDv>; Sun, 2 Feb 2003 16:03:51 -0500
Received: from [81.2.122.30] ([81.2.122.30]:53765 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265578AbTBBVDu>;
	Sun, 2 Feb 2003 16:03:50 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302022114.h12LEBro008887@darkstar.example.net>
Subject: Re: menuconfig
To: b_adlakha@softhome.net
Date: Sun, 2 Feb 2003 21:14:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <courier.3E3D87F0.00001F1B@softhome.net> from "b_adlakha@softhome.net" at Feb 02, 2003 02:04:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> why does everything have (new) after it in the ncurses based config for 
> 2.5.59? Even the old OSS sound modules are new?

It means 'new' as in 'has not been presented to the user before'.
Once you've selected the option, it is no longer displayed as new.

> And also,
> the <save configuration to alternate file> doesn't work alright...It can't 
> access anything outside the kernel sources folder saying that the location 
> does not exist... 

It works fine here, are you sure you have the relevant permissions set
correctly?

John.
