Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130348AbQKGWzO>; Tue, 7 Nov 2000 17:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130350AbQKGWzF>; Tue, 7 Nov 2000 17:55:05 -0500
Received: from raven.toyota.com ([205.180.183.200]:29196 "EHLO
	raven.toyota.com") by vger.kernel.org with ESMTP id <S130348AbQKGWyx>;
	Tue, 7 Nov 2000 17:54:53 -0500
Message-ID: <3A08883A.A8A1CF90@toyota.com>
Date: Tue, 07 Nov 2000 14:54:50 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.4.21.0011072328050.22346-100000@tux.rsn.hk-r.se> <3A08830E.F714C90E@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:

> So how come NetWare and NT can detect this at run time, and we have to
> use a .config option to specifiy it?  Come on guys.....

Linux detects this as well -

However this is not about detection, but optimizations.

Optimizations e.g. for xeon could keep a K6/2 from booting!

It should probably default to something safe like 386 though...


jjs


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
