Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWCPNkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWCPNkE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 08:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWCPNkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 08:40:04 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:4107 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750925AbWCPNkD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 08:40:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <20060315231029.GF4454@stusta.de>
x-originalarrivaltime: 16 Mar 2006 13:40:00.0645 (UTC) FILETIME=[1F596350:01C648FF]
Content-class: urn:content-classes:message
Subject: Re: Which kernel is the best for a small linux system?
Date: Thu, 16 Mar 2006 08:39:54 -0500
Message-ID: <Pine.LNX.4.61.0603160836270.7151@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Which kernel is the best for a small linux system?
Thread-Index: AcZI/x9j4qMUC0GFS2uDV/HzjKAmKg==
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com> <1142237867.3023.8.camel@laptopd505.fenrus.org> <20060313182725.GA31211@mars.ravnborg.org> <Pine.LNX.4.61.0603152355460.20859@yvahk01.tjqt.qr> <20060315231029.GF4454@stusta.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Sam Ravnborg" <sam@ravnborg.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "j4K3xBl4sT3r" <jakexblaster@gmail.com>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Mar 2006, Adrian Bunk wrote:

> On Wed, Mar 15, 2006 at 11:57:12PM +0100, Jan Engelhardt wrote:
>>>
>>> On another denx.de page I found this summary (so you do not have to
>>> visit the page):
>>> # slow to build: 2.6 takes 30...40% longer to compile
>>
>> A side effect of all the new optimizations that went into gcc since 2.95,
>> I would say.
>
> If you would have had a quick look at the results on the webpage you are
> commenting on instead of blindly speculating, you'd have known that your
> statement is bullshit since both the 2.4 and the 2.6 compiles were done
> using gcc 3.3.3.
>
>> Jan Engelhardt
>
> cu
> Adrian

There have been no systemic problems with 2.4.26 in small and
embedded systems -- for whatever that's worth. Stuff might not
be "optimum", but networking of all types, and the usual
unistd.h stuff all works fine. It's good for systems you
don't want to have to muck with.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
