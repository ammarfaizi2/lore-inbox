Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbTA1Npu>; Tue, 28 Jan 2003 08:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTA1Npu>; Tue, 28 Jan 2003 08:45:50 -0500
Received: from [81.2.122.30] ([81.2.122.30]:30212 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265306AbTA1Npt>;
	Tue, 28 Jan 2003 08:45:49 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301281355.h0SDteN1000666@darkstar.example.net>
Subject: Re: Bootscreen
To: stepan@suse.de (Stefan Reinauer)
Date: Tue, 28 Jan 2003 13:55:39 +0000 (GMT)
Cc: rob@r-morris.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20030128133252.GC23296@suse.de> from "Stefan Reinauer" at Jan 28, 2003 02:32:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There is a very simple reason why Linux shouldn't have a "bootscreen" - 
> > its a lame idea.
> 
> Then why not make something better instead of denying it completely.

Surely the most sensible lines to think along are:

* Make boot times as short as possible
* Support, and encourage the use of more efficient CPU designs, so
  that it becomes sensible to leave machines on all the time.

Then, the issue of a bootscreen becomes a non-issue.

John.
