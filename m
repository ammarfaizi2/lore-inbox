Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267293AbTGROvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268255AbTGROsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:48:53 -0400
Received: from vdp160.ath01.cas.hol.gr ([195.97.116.161]:24960 "EHLO
	pfn1.pefnos") by vger.kernel.org with ESMTP id S271716AbTGROJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:09:13 -0400
From: "P. Christeas" <p_christ@hol.gr>
To: Scott Robert Ladd <coyote@coyotegulch.com>
Date: Fri, 18 Jul 2003 17:26:32 +0300
User-Agent: KMail/1.5
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [PATCH] PATCH: typo bits (aka. linguistics in lkml)
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307181726.32548.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Alan Cox wrote:
>>>>- * It's now support isochronous mode and more effective than hc_sl811.o
>>>>+ * It's now support isosynchronous mode and more effective than 
hc_sl811.o
>>>
>>>I thought the correct term was `isochronous'...
>> 
>> Perhaps someone can clarify - however isochornus is definitely wrong either 
way

>"Isochronous" is correct; it is a synonym for "isochronal", which means 
>"uniform in time; of equal duration". That is, I believe, apropos to the 
>intended meaning of the comment above.

>"Isosynchronous" does not appear in any of my dictionaries.

Exactly. The valid word is 'isochronous', which characterizes timeslices of 
equal length.
It is different from 'synchronous', which is thhings that happen at the same 
time, i.e. in parallel. In some extent, this word is used to mean things that 
will also end at the same time.

