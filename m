Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbTBCOUP>; Mon, 3 Feb 2003 09:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbTBCOUP>; Mon, 3 Feb 2003 09:20:15 -0500
Received: from [81.2.122.30] ([81.2.122.30]:56069 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266379AbTBCOUO>;
	Mon, 3 Feb 2003 09:20:14 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302031430.h13EUW7O016859@darkstar.example.net>
Subject: Re: Compactflash cards dying?
To: Padraig@Linux.ie
Date: Mon, 3 Feb 2003 14:30:32 +0000 (GMT)
Cc: mkp@mkp.net, bryan@bogonomicon.net, pavel@ucw.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <3E3E7841.4090906@Linux.ie> from "Padraig@Linux.ie" at Feb 03, 2003 02:10:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Bryan> You would be surprised how fast a million writes can happen on
> > Bryan> a disk.
> 
> especially if you don't mount with noatime.

noatime only suppresses access time updating on reads, writes still
update the access time.

John
