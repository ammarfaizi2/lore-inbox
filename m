Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131083AbQLYPZQ>; Mon, 25 Dec 2000 10:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130664AbQLYPY4>; Mon, 25 Dec 2000 10:24:56 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:62725 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130635AbQLYPYw>; Mon, 25 Dec 2000 10:24:52 -0500
Date: 25 Dec 2000 13:12:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Message-ID: <7sX4YyEmw-B@khms.westfalen.de>
In-Reply-To: <20001224125023.A1900@scutter.internal.splhi.com>
Subject: Re: About Celeron processor memory barrier problem
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <7sSHLPCmw-B@khms.westfalen.de> <kaih@khms.westfalen.de> <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com> <7sSHLPCmw-B@khms.westfalen.de> <20001224125023.A1900@scutter.internal.splhi.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

timw@splhi.com (Tim Wright)  wrote on 24.12.00 in <20001224125023.A1900@scutter.internal.splhi.com>:

> On Sun, Dec 24, 2000 at 11:36:00AM +0200, Kai Henningsen wrote:

> There was a similar thread to this recently. The issue is that if you
> choose the wrong processor type, you may not even be able to complain.

Hmm ... I think I can see ways around that (essentially similar to the 16  
bit bootstrap code), but it may indeed be more trouble than it's worth.

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
