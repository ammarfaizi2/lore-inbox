Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbTAaOsp>; Fri, 31 Jan 2003 09:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbTAaOsp>; Fri, 31 Jan 2003 09:48:45 -0500
Received: from [81.2.122.30] ([81.2.122.30]:56327 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261330AbTAaOso>;
	Fri, 31 Jan 2003 09:48:44 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301311458.h0VEwqFS001441@darkstar.example.net>
Subject: Re: [PATCH] 2.5.59 morse code panics
To: Valdis.Kletnieks@vt.edu
Date: Fri, 31 Jan 2003 14:58:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301311440.h0VEeRlH005883@turing-police.cc.vt.edu> from "Valdis.Kletnieks@vt.edu" at Jan 31, 2003 09:40:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's a *REASON* that IBM RS/6K boxes have at least a little 3-digit LED
> display - during boot or a panic, even if you can't trust the console drivers
> anymore, you can still output *something*.

By the way, you can buy cards with LED displays on which monitor port
80h, and tell you how far through the boot process a box is getting.
Not much use on a laptop, though :-).

John.
