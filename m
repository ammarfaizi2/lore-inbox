Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129291AbRAYPB0>; Thu, 25 Jan 2001 10:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129390AbRAYPAS>; Thu, 25 Jan 2001 10:00:18 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:29969 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130966AbRAYO74>; Thu, 25 Jan 2001 09:59:56 -0500
Date: 25 Jan 2001 15:25:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7uYrAAR1w-B@khms.westfalen.de>
In-Reply-To: <200101231600.LAA24562@mah21awu.cas.org>
Subject: Re: [OT?] Coding Style
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCCD@zcard00g.ca.nortel.com> <200101231600.LAA24562@mah21awu.cas.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mharrold@cas.org (Mike Harrold)  wrote on 23.01.01 in <200101231600.LAA24562@mah21awu.cas.org>:

> > I prefer descriptive variable and function names - like comments, they
> > help to make code so much easier to read.
> >
> > One thing I wonder though... why do people prefer 'some_function_name()'
> > over 'SomeFunctionName()'?  I personally don't like the underscore
> > character - it's an odd character to type when you're trying to get the
> > name typed in, and the shifted character, I find, is easier to input.
> >
>
> For exactly the reverse of that reason. Typing capital letters is a heck
> of a lot more difficult that addint an underscore.

(shift)+(-_) is a lot more more difficult than (shift)+(A)?

Or do you have a keyboard layout where _ is not a shifted key?

> Then there is reasability.
>
>   void ThisIsMyDumbassFunctionName
>
> if MUCH more difficult to read than
>
>   void this_is_my_clear_and_easy_function_name

I can certainly read the first easier than the second.

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
