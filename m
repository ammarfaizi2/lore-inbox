Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278614AbRJSTQh>; Fri, 19 Oct 2001 15:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278616AbRJSTQ2>; Fri, 19 Oct 2001 15:16:28 -0400
Received: from internet.sk ([192.108.130.91]:47114 "EHLO internet.eunet.sk")
	by vger.kernel.org with ESMTP id <S278615AbRJSTQQ>;
	Fri, 19 Oct 2001 15:16:16 -0400
From: "Stanislav Meduna" <stano@meduna.org>
To: "Dan Siemon" <dan@coverfire.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: USB stability - possibly printer related
Date: Fri, 19 Oct 2001 21:16:46 +0200
Message-ID: <AHEMIKPKMHEEJBKHLIGHEEFGCAAA.stano@meduna.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <1003518067.16964.22.camel@cr156960-a>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I have not had time to risk killing my system again but
> it appears to be either related to postscript printing
> or the lm_sensors modules. Do you by chance use lm_sensors?

No, I don't.

> I am pretty sure I can make it happen again but I don't have
> the time to reinstall my system right now...

I can experiment, provided that only the mounted partitions
can be hosed this way. But if this is some memory corruption,
maybe anything could go wrong...

> > - I got a corruption of the files that were surely _not_
> >   opened for writing.
> 
> Here too. Many system libs were corrupted. When fsck tried
> to repair the file system it spewed all kinds of errors
> about libs.

Kernel gurus: it seems this is a common symptom. Could someone
give some explanation/speculation, what mechanismus can lead
to this kind of corruption (not necessarily related to USB)?

Regards
-- 
                                   Stano

