Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160406AbQHATak>; Tue, 1 Aug 2000 15:30:40 -0400
Received: by vger.rutgers.edu id <S160207AbQHAT3q>; Tue, 1 Aug 2000 15:29:46 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:3305 "EHLO mailout04.sul.t-online.com") by vger.rutgers.edu with ESMTP id <S160432AbQHAT2c>; Tue, 1 Aug 2000 15:28:32 -0400
Date: 01 Aug 2000 20:15:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.rutgers.edu
Message-ID: <7j03YrrXw-B@khms.westfalen.de>
In-Reply-To: <20000801073357Z157113-15702+213@vger.rutgers.edu>
Subject: Re: RLIM_INFINITY inconsistency between archs
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <20000801073357Z157113-15702+213@vger.rutgers.edu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: owner-linux-kernel@vger.rutgers.edu

David.Howells@nexor.co.uk (David Howells)  wrote on 01.08.00 in <20000801073357Z157113-15702+213@vger.rutgers.edu>:

> Kai Henningsen wrote:
> > I notice just about everybody suggesting absolute paths.
> >
> > Try relative paths or environment variables instead. This has the
> > advantage of working anywhere you damn well please.
>
> Relative to what? Which environment variables? Who sets these variables?

Relative paths are relative to the current directory, and have always been  
that way.

And of course, those environment variables would be set by the user.

What's so hard to understand about this?


MfG Kai

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
