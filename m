Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267740AbTBGIfg>; Fri, 7 Feb 2003 03:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267738AbTBGIfg>; Fri, 7 Feb 2003 03:35:36 -0500
Received: from [81.2.122.30] ([81.2.122.30]:27908 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267737AbTBGIff>;
	Fri, 7 Feb 2003 03:35:35 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302070845.h178j17Y000487@darkstar.example.net>
Subject: Re: [PATCH 2.5] fix megaraid driver compile error
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 7 Feb 2003 08:45:01 +0000 (GMT)
Cc: dwmw2@infradead.org, markh@osdl.org, elenstev@mesatop.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302061519360.14478-100000@home.transmeta.com> from "Linus Torvalds" at Feb 06, 2003 03:22:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Cut and paste from xterm should work fine. Cut and paste from
> > gnome-terminal, OTOH, will often corrupt it for you.
> 
> I think xterm does the same thing. I certainly refuse to use inferior 
> clones (I don't understand why people even _bother_ with things like 
> gnome-terminal, since it can't even do proper vt100 sequences), and I 
> definitely get tab->space conversion between two xterms.

I get tab->space conversion with both xterm and rxvt.

Cut and paste from xemacs preserves tabs.

John.
