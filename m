Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWAZVcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWAZVcE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWAZVcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:32:03 -0500
Received: from spirit.analogic.com ([204.178.40.4]:62733 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1750708AbWAZVcC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:32:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <43D93B4D.20601@yahoo.com.au>
X-OriginalArrivalTime: 26 Jan 2006 21:31:30.0003 (UTC) FILETIME=[DEE11A30:01C622BF]
Content-class: urn:content-classes:message
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Thu, 26 Jan 2006 16:31:28 -0500
Message-ID: <Pine.LNX.4.61.0601261621250.10049@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Thread-Index: AcYiv97qmR0ICGzvTM6mKM31IOE9xg==
References: <20060124225919.GC12566@suse.de>  <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>  <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>  <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com> <43D8EFF7.3070203@yahoo.com.au> <43D8FC76.2050906@symas.com> <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com> <43D91C33.7050401@yahoo.com.au> <Pine.LNX.4.61.0601261405320.9584@chaos.analogic.com> <43D93B4D.20601@yahoo.com.au>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: "Howard Chu" <hyc@symas.com>, "Lee Revell" <rlrevell@joe-job.com>,
       "Christopher Friesen" <cfriesen@nortel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <hancockr@shaw.ca>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Jan 2006, Nick Piggin wrote:
[SNIPPED...]

> Any chance you can get rid of that crazy disclaimer when posting
> to lkml, please?
>
> Thanks,
> Nick
> --
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com
>

I tried. The "!@#(*$%^~!" IT/Legal Department(s) don't have a clue.
I asked the "mail-filter" guy on linux-kernel if he could just
exclude everything after a "." in the first column, just like
/bin/mail and, for that matter, sendmail. I was just told that
"It doesn't...." even though I can run sendmail by hand, using
telnet port 25, over the network, and know that the "." in the
first column is the way it knows the end-of-message after it
receives the "DATA" command.

Hoping that somebody, sometime, will implement my suggestion,
I continue to put a dot in the first column after my signature.
I know that if I send my mail around the lab without going through
the "*(_!@#&%" MicroWorm mail-grinder, the dot gets rid of
everything thereafter.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
