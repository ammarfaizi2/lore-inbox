Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266903AbSL3KwV>; Mon, 30 Dec 2002 05:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbSL3KwV>; Mon, 30 Dec 2002 05:52:21 -0500
Received: from [81.2.122.30] ([81.2.122.30]:56324 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266903AbSL3KwU>;
	Mon, 30 Dec 2002 05:52:20 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212301100.gBUB0105000718@darkstar.example.net>
Subject: Re: kernel compilation: pls send cc to me
To: joshk@ludicrus.ath.cx (Joshua M. Kwan)
Date: Mon, 30 Dec 2002 11:00:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, abacus_an@yahoo.co.in
In-Reply-To: <20021230104357.GB13892@localhost> from "Joshua M. Kwan" at Dec 30, 2002 02:43:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, I stand corrected. I never noticed any difference compiling with 
> gcc-2.95 versus compiling with 3.2.
> 
> What is the recommended version then?

Well, as far as I know it's still officially 2.95.3 for both 2.4 and
2.5.

There shouldn't be _major_ problems compiling with 3.2, but it has had
far less testing, so something like a filesystem corruption bug could
go unnoticed for longer if it wasn't happening with 2.95.3 compiled
kernels as well.

John.
