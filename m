Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135306AbRA2Qac>; Mon, 29 Jan 2001 11:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135497AbRA2QaW>; Mon, 29 Jan 2001 11:30:22 -0500
Received: from h56s242a129n47.user.nortelnetworks.com ([47.129.242.56]:20427
	"EHLO zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S135306AbRA2QaN>; Mon, 29 Jan 2001 11:30:13 -0500
Message-ID: <28560036253BD41191A10000F8BCBD116BDCE3@zcard00g.ca.nortel.com>
From: "Jonathan Earle" <jearle@nortelnetworks.com>
To: "'Jeremy M. Dolan'" <jmd@foozle.turbogeek.org>,
        David Ford <david@linux.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] doc update/fixes for sysrq.txt
Date: Mon, 29 Jan 2001 10:49:24 -0500
X-Mailer: Internet Mail Service (5.5.2652.35)
X-Orig: <jearle@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 28 Jan 2001 11:35:50 +0000, David Ford wrote:
> > AFAIK, this hasn't ever been true.  I have never had to specifically
> > enable it at run time.
> 
> I was suspicious of that in the old doc but thought I'd leave it in...
> Should have asked for feedback on it, but you caught it 
> anyway, thanks!
> 
> Here's a patch against the first that simply removes the lines.

I'd suggest leaving those lines in; I've never had it enabled by default.
I've run Debian and Redhat systems, and both had to have the option
specifically turned ON via startup script - simply compiling it into a
kernel did not enable it.

Jon
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
