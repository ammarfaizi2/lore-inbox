Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbRAVO2g>; Mon, 22 Jan 2001 09:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131260AbRAVO20>; Mon, 22 Jan 2001 09:28:26 -0500
Received: from cicero0.cybercity.dk ([212.242.40.52]:38417 "HELO
	cicero0.cybercity.dk") by vger.kernel.org with SMTP
	id <S130154AbRAVO2U>; Mon, 22 Jan 2001 09:28:20 -0500
Message-ID: <003701c08481$2461a300$27f8423e@avenger>
From: "Henrik Stokseth" <hstokset@privat.cybercity.no>
To: "Tom" <freyason@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010122131145.46874.qmail@web11607.mail.yahoo.com>
Subject: Re: Proper OOPS report
Date: Mon, 22 Jan 2001 15:39:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you were the one with the gcc 2.95.3 compiler right? even though this
compiler is a prerelease of a stable branch i have confirmed errors in the
optimalization passes. my advice: use a compiler which really IS stable
(gcc-2.95.2 or egcs-1.1.2 are fine), or turn off all optimalizations.

-henrik

----- Original Message -----
From: Tom <freyason@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, January 22, 2001 2:11 PM
Subject: Proper OOPS report


> My apologies for not running it through ksymoops.
> No specific bit of code was referenced in the OOPS so I am assuming
> it is in the kernel itself.
<snip>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
