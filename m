Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbTAGGhK>; Tue, 7 Jan 2003 01:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267319AbTAGGhK>; Tue, 7 Jan 2003 01:37:10 -0500
Received: from sj-msg-core-3.cisco.com ([171.70.157.152]:36791 "EHLO
	sj-msg-core-3.cisco.com") by vger.kernel.org with ESMTP
	id <S267315AbTAGGhJ>; Tue, 7 Jan 2003 01:37:09 -0500
Message-Id: <5.1.0.14.2.20030107174201.038ad1a8@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 07 Jan 2003 17:45:03 +1100
To: Valdis.Kletnieks@vt.edu
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set
  NOW!) 
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200301070538.h075cICR004033@turing-police.cc.vt.edu>
References: <Your message of "Mon, 06 Jan 2003 22:20:46 CST." <20030107042045.GA10045@waste.org>
 <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org>
 <3E19B401.7A9E47D5@linux-m68k.org>
 <17360000.1041899978@localhost.localdomain>
 <20030107042045.GA10045@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:38 AM 7/01/2003 -0500, Valdis.Kletnieks@vt.edu wrote:
> > What was the underlying error rate and distribution you assumed? I
> > figure if it were high enough to get to your 1%, you'd have such high
> > retry rates (and resulting throughput loss) that the operator would
> > notice his LAN was broken weeks before said transfer completed.
>
>The average ISP wouldn't notice things were broken unless enough magic
>smoke escaped to cause a Halon dump.
>
>Consider as evidence the following NANOG presentation:
>http://www.nanog.org/mtg-0210/wessels.html
>
>Some *98* percent of all queries at one of the root nameservers over a 24-hour
>period were broken in some way.

please don't confuse issues.
i think you just epitomized the quote: "there are lies, damn lies, and 
statistics".

you're trying to say that because there is some broken/buggy nameserver 
code out there, it means that the error-rate for TCP is correct?


cheers,

lincoln.

