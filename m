Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268031AbTBXEwh>; Sun, 23 Feb 2003 23:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267990AbTBXEwh>; Sun, 23 Feb 2003 23:52:37 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:61886 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268031AbTBXEwf>;
	Sun, 23 Feb 2003 23:52:35 -0500
To: davidm@hpl.hp.com
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Minutes from Feb 21 LSE Call 
In-reply-to: Your message of Sun, 23 Feb 2003 20:07:43 PST.
             <15961.39567.749201.870556@napali.hpl.hp.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3934.1046062936.1@us.ibm.com>
Date: Sun, 23 Feb 2003 21:02:16 -0800
Message-Id: <E18nAkr-00011W-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003 20:07:43 PST, David Mosberger wrote:
> >>> On Sun, 23 Feb 2003 19:49:38 -0800, Gerrit Huizenga <gh@us.ibm.com> said:
> 
>   Gerrit> I haven't seen anything recently on the higher level System bencmarks
>   Gerrit> for IA64
> 
> Did you miss the TPC-C announcement from last November & December?
> 
>  rx5670 4-way Itanium 2: 80498 tpmC @ $5.30/transaction (Oracle 10 on Linux).
>  rx5670 4-way Itanium 2: 87741 tpmC @ $5.03/transaction (MS SQL on Windows).
> 
> Both world-records for 4-way machines when they were announced (not
> sure if that's still true).

Yeah, I missed that.  And my spot checking didn't catch anything IA64
related.  Was there anything else on IA64 that competed with the current
rack of 8-way IA32 boxen, or the upcoming 16-way stuff rolling out
this year?  Seems like the larger phys memory support should help on
several of those benchmarks...

The thin number of IA64 results indicates the difference in marketing/sales,
although better price/performance should be able to change that... ;)

Odd that MS is still outdoing Linux (or SQL is outdoing Oracle on Linux).
Will be nice when that changes...

gerrit
