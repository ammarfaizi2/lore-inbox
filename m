Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131096AbRAWObC>; Tue, 23 Jan 2001 09:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131104AbRAWOaw>; Tue, 23 Jan 2001 09:30:52 -0500
Received: from web11604.mail.yahoo.com ([216.136.172.56]:1296 "HELO
	web11604.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131096AbRAWOan>; Tue, 23 Jan 2001 09:30:43 -0500
Message-ID: <20010123143042.59117.qmail@web11604.mail.yahoo.com>
Date: Tue, 23 Jan 2001 06:30:42 -0800 (PST)
From: Tom <freyason@yahoo.com>
Subject: Re: Proper OOPS report
To: Henrik Stokseth <hstokset@privat.cybercity.no>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Henrik Stokseth <hstokset@privat.cybercity.no> wrote:
> you were the one with the gcc 2.95.3 compiler right? even though this
> compiler is a prerelease of a stable branch i have confirmed errors
> in the
> optimalization passes. my advice: use a compiler which really IS
> stable
> (gcc-2.95.2 or egcs-1.1.2 are fine), or turn off all optimalizations.
> 
> -henrik

The kernel was compiled with 2.95.2.. I did not upgrade to 2.95.3 until
a week after I compiled the kernel.

Tom

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices. 
http://auctions.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
