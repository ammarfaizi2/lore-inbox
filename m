Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160331AbQGaQlr>; Mon, 31 Jul 2000 12:41:47 -0400
Received: by vger.rutgers.edu id <S160093AbQGaQkG>; Mon, 31 Jul 2000 12:40:06 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:4587 "EHLO mailout01.sul.t-online.com") by vger.rutgers.edu with ESMTP id <S160758AbQGaQR6>; Mon, 31 Jul 2000 12:17:58 -0400
Date: 31 Jul 2000 17:26:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.rutgers.edu
Message-ID: <7iw6lD2Xw-B@khms.westfalen.de>
In-Reply-To: <20000728112353Z160228-16385+645@vger.rutgers.edu>
Subject: Re: RLIM_INFINITY inconsistency between archs
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <20000728112353Z160228-16385+645@vger.rutgers.edu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: owner-linux-kernel@vger.rutgers.edu

David.Howells@nexor.co.uk (David Howells)  wrote on 28.07.00 in <20000728112353Z160228-16385+645@vger.rutgers.edu>:

> Why not /usr/modules or /usr/kernel for the stuff required to compile
> modules (in other words stuff that the kernel doesn't actually use), for
> example:

I notice just about everybody suggesting absolute paths.

Try relative paths or environment variables instead. This has the  
advantage of working anywhere you damn well please.


MfG Kai

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
