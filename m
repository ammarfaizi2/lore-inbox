Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRDWIGc>; Mon, 23 Apr 2001 04:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRDWIGW>; Mon, 23 Apr 2001 04:06:22 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:32274 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S131497AbRDWIGJ>; Mon, 23 Apr 2001 04:06:09 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: george anzinger <george@mvista.com>
Date: Mon, 23 Apr 2001 10:05:48 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: No 100 HZ timer!
CC: linux-kernel@vger.kernel.org
Message-ID: <3AE3FE79.9982.6C4B69@localhost>
In-Reply-To: <3ADC912A.B497B724@mvista.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO the POSIX is doable to comply with POSIX. Probably not what many 
of the RT freaks expect, but doable. I'm tuning the nanoseconds for a 
while now...

Ulrich

On 17 Apr 2001, at 11:53, george anzinger wrote:

> I was thinking that it might be good to remove the POSIX API for the
> kernel and allow a somewhat simplified interface.  For example, the user

