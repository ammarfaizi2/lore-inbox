Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132022AbRATTzM>; Sat, 20 Jan 2001 14:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132115AbRATTzD>; Sat, 20 Jan 2001 14:55:03 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:8210 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132022AbRATTyu>; Sat, 20 Jan 2001 14:54:50 -0500
Date: 20 Jan 2001 16:56:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7uDh9dHmw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.30.0101181840380.16292-100000@twinlark.arctic.org>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3A660746.543226B@cup.hp.com> <Pine.LNX.4.30.0101181840380.16292-100000@twinlark.arctic.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean-list-linux-kernel@arctic.org (dean gaudet)  wrote on 18.01.01 in <Pine.LNX.4.30.0101181840380.16292-100000@twinlark.arctic.org>:

> i'm pretty sure the actual use of pipelining is pretty disappointing.
> the work i did in apache preceded the widespread use of HTTP/1.1 and we

What widespread use of HTTP/1.1?

I justtried the following excercise:

Request a nonexistant page with HTTP/1.1 syntax.

a. Directly from Apache: I get a nice chunked HTTP/1.1 answer.
b. Via Squid: I get a plain HTTP/1.0 answer.

As long as not even Squid talks 1.1, how can we expect browsers to do it?

WebMUX? In a thousand years perhaps.

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
