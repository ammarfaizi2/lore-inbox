Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbSLINbt>; Mon, 9 Dec 2002 08:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbSLINbs>; Mon, 9 Dec 2002 08:31:48 -0500
Received: from [81.2.122.30] ([81.2.122.30]:60164 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265477AbSLINbr>;
	Mon, 9 Dec 2002 08:31:47 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212091350.gB9DouN1000766@darkstar.example.net>
Subject: Re: 486 laptop apm problems
To: ernte23@gmx.de (Felix Triebel)
Date: Mon, 9 Dec 2002 13:50:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021209133058.GA3724@mob.wid> from "Felix Triebel" at Dec 09, 2002 02:30:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> why does apmd frequently crash?
> what do all these ide and apm messages mean?
> how should I use such an old apm bios?

The IDE messages are warning messages, not critical errors - you can
ignore them.

Please run the oops through ksymoops and post the output.

John.
