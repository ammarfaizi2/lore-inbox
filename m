Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267257AbTA0Rqj>; Mon, 27 Jan 2003 12:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTA0Rqi>; Mon, 27 Jan 2003 12:46:38 -0500
Received: from [81.2.122.30] ([81.2.122.30]:3333 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267257AbTA0Rqd>;
	Mon, 27 Jan 2003 12:46:33 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301271755.h0RHtgXu000960@darkstar.example.net>
Subject: Re: Adaptec scsi issue kernel 2.4.19/20
To: jgofton@danicar.net
Date: Mon, 27 Jan 2003 17:55:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <28774.207.34.24.8.1043689627.squirrel@www.danicar.net> from "Joe Gofton" at Jan 27, 2003 01:47:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a known problem and is there a fix?  I can't seem to upgrade my
> kernel without scsi issues.

I have an Adaptec 2940AU which has worked perfectly with 2.4.18,
2.4.19, 2.4.20, including various pre and rc trees.  The only problem
I've had recently was 2.4.19-pre1, which has a known compile issue,
which was fixed in 2.4.19-pre2.  The 2.5.x tree has worked fine with
my 2940AU for months.

So, it's not a general problem with the adaptec driver.

John.
