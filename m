Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311520AbSCNFah>; Thu, 14 Mar 2002 00:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311523AbSCNFa2>; Thu, 14 Mar 2002 00:30:28 -0500
Received: from air-2.osdl.org ([65.201.151.6]:33801 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S311520AbSCNFaQ>;
	Thu, 14 Mar 2002 00:30:16 -0500
Date: Wed, 13 Mar 2002 21:29:22 -0800 (PST)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bill Davidsen <davidsen@tmr.com>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <E16lHb0-0007go-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203132126420.15352-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Alan Cox wrote:

| > I'm looking at P4 chips and boards, my 2Q02 budget has some $$ for a
| > system. I also will be getting some laptops 3Q02, does the new P4-M mobile
| > chip by any chance have HT? If so a good reason to go Intel, assuming that
| > either the BIOS or Linux can get it to use the feature ;-)

They announced at IDF last week (or 2 weeks back) that "UP"
P4 next year sometime will include HT.
I think this is "Prescott."

I haven't heard details about the P4-M, but I doubt that
it has HT (yet).

| At the moment HT is Xeon only. Linux can do the right thing with it as of
| 2.4.18 + acpismp=force. Autodetect should be in soon. I don't know about
| Intel's future product plans for HT.

-- 
~Randy

