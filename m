Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319058AbSIJHBT>; Tue, 10 Sep 2002 03:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319059AbSIJHBT>; Tue, 10 Sep 2002 03:01:19 -0400
Received: from khms.westfalen.de ([62.153.201.243]:24525 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S319058AbSIJHBR>; Tue, 10 Sep 2002 03:01:17 -0400
Date: 10 Sep 2002 08:59:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8WbPErQ1w-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0209090831240.1641-100000@home.transmeta.com>
Subject: Re: [BK] PATCH ReiserFS 1 of 3 RESEND
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <20020909113147.BBA73A7CDF@reload.namesys.com> <Pine.LNX.4.44.0209090831240.1641-100000@home.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 09.09.02 in <Pine.LNX.4.44.0209090831240.1641-100000@home.transmeta.com>:

> where "reload.namesys.com" is not in the MX domain:
>
> 	dig -t MX reload.namesys.com

... i.e., does not have a MX record.

> (Yes, I realize that both addresses likely work perfectly fine, and that

Since the RFCs *demand* that an address mentioned in mail has an MX  
record, and the fallback to A records was not, until recently, described,  
there probably are some mailers that cannot deliver mail to that address.  
Which, in my book, counts as "not perfectly fine", even though I admit  
those mailers are probably in a minority as, sadly, this particular  
disease is pretty widespread.

Still. I personally count it as a bug just the same as using an implicit  
extern to call a function.

> [ Cc to linux-kernel left intact not to publicly castigate Hans, but
>   because I know this is true for some other people too. ]

Similar here.

MfG Kai
