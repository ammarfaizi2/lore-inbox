Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286942AbSASTHj>; Sat, 19 Jan 2002 14:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286962AbSASTHa>; Sat, 19 Jan 2002 14:07:30 -0500
Received: from khms.westfalen.de ([62.153.201.243]:11734 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S287002AbSASTHR>; Sat, 19 Jan 2002 14:07:17 -0500
Date: 19 Jan 2002 20:01:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8HBE2ej1w-B@khms.westfalen.de>
In-Reply-To: <20020119145132.GA972@online.fr>
Subject: Re: rm-ing files with open file descriptors
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20020119041857.GA10795@storm.local> <87lmevjrep.fsf@localhost.localdomain> <20020119041857.GA10795@storm.local> <20020119145132.GA972@online.fr>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe.barbe.ml@online.fr (christophe barbé)  wrote on 19.01.02 in <20020119145132.GA972@online.fr>:

> On Sat, Jan 19, 2002 at 05:18:57AM +0100, Andreas Bombe wrote:
> > Whether that was an intended or accidental feature only someone with
> > more insight into Unix history can answer.  It's that feature that lets
> > us do live upgrades of distributions without rebooting (executables and
> > libraries can be replaced without affecting the currently running
> > processes), at the very least much easier than it would be without this
> > behaviour.
>
> I remember that previous debian release come with a patched kernel to
> allow live upgrade. It was explained in the FAQ that the patch was
> required for this purpose.

Complete and utter bullshit. This was never true, and the FAQ never  
claimed this.

>    7.2 Debian claims to be able to update a running program;
>       how is this accomplished?

... under which was originally explained how running demons would be  
restarted, and later it was also mentioned that replacing in-use files is  
possible under Unix. Nothing more. (Google groups will happily find those  
versions, they were in use from 1996 to 2001 according to the archive.)

> What was in this patch?

The patch only exists in your fantasy.

MfG Kai
