Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274055AbRISNPx>; Wed, 19 Sep 2001 09:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274049AbRISNPj>; Wed, 19 Sep 2001 09:15:39 -0400
Received: from denise.shiny.it ([194.20.232.1]:733 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S274051AbRISNPY>;
	Wed, 19 Sep 2001 09:15:24 -0400
Message-ID: <XFMail.20010919151538.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010919133023.G639@suse.de>
Date: Wed, 19 Sep 2001 15:15:38 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.4.9-ac10 hangs on CDROM read error
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xavier Bestel <xavier.bestel@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > I have an ABit VP6, CDRW as hdc and DVD as hdd (VIA vt82c686b IDE
>> > driver), with SCSI emulation on top, and when I read either:
>> >
>> > - a DVD with a read error in the DVD drive (UDF mounted, ripping)
>> >
>> > - a CDR with a read error in the CDRW drive (ISO mounted)
>> >
>> > the system hangs - no ping, no sysrq, nothing. no log.
>>
>> I have the same problem with PowerMac G3 and G4 with IDE drives. No
>> problems with SCSI, where read just stops with an I/O error.
>
> Could one of you hook up a serial console and attempt to capture any
> oops info?

No oops or panic or anything, as far as I can remember. I have access
to a IDE equipped G4 right now. I'll try to reproduce the lockup this
night (hmm, what CD can I scrape? :)) ). Stay tuned...


Bye.

