Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAKUVI>; Thu, 11 Jan 2001 15:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbRAKUU7>; Thu, 11 Jan 2001 15:20:59 -0500
Received: from front2.grolier.fr ([194.158.96.52]:24228 "EHLO
	front2.grolier.fr") by vger.kernel.org with ESMTP
	id <S129631AbRAKUUo> convert rfc822-to-8bit; Thu, 11 Jan 2001 15:20:44 -0500
Date: Thu, 11 Jan 2001 20:20:03 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Boszormenyi Zoltan <zboszor@externet.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: sym-2.1.0-20001230 vs. sg (cdrecord)
In-Reply-To: <Pine.LNX.4.02.10101111504570.9158-100000@prins.externet.hu>
Message-ID: <Pine.LNX.4.10.10101112009300.1697-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2001, Boszormenyi Zoltan wrote:

> Hi!
> 
> I just wanted to let you know that I successfully ruined
> a CD with 2.4.0 + sym-2.1.0-20001230. The system is a RH 7.0
> with glibc-2.2-9, cdrecord-1.9.

Thanks for the report.
But with so tiny information, it gives about no usefulness to me.

> When will it be really usable?

A single ruined CD is probably too weak a symptom for stating any serious
sickness in the driver. FYI, I cannot even personnaly try to ruin a single
CDR, for the reason I don't have CDR.

If you can retrieve information related to the failure, you may send me
them (syslog messages, cdrecord output messages, etc...). Thanks in
advance. You may also give a try with stable kernel and related stuff and 
let me know the result.

Regards,
  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
