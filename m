Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbTA1KWk>; Tue, 28 Jan 2003 05:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTA1KWk>; Tue, 28 Jan 2003 05:22:40 -0500
Received: from [81.2.122.30] ([81.2.122.30]:10244 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265058AbTA1KWj>;
	Tue, 28 Jan 2003 05:22:39 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301281032.h0SAWYip000289@darkstar.example.net>
Subject: Re: AW: Bootscreen
To: Raphael_Schmid@CUBUS.COM (Raphael Schmid)
Date: Tue, 28 Jan 2003 10:32:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <398E93A81CC5D311901600A0C9F29289469372@cubuss2> from "Raphael Schmid" at Jan 28, 2003 11:01:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it be possible/easy (i.e.: the least
> way of resistance) to modify the kernel so
> that console initialization does not happen
> until everything is up and running? What I
> was up to in the first place was getting into
> X as fast as possible, and without too many
> different screens.

There is a boot option to do this, but I can't remember what it is :-)

It's something like boot=silent, or something.

then, you just get:

LILO loading linux...
Uncompressing the kernel...

Welcome to Linux 2.4.20
login:

John.
