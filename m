Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290265AbSAOTha>; Tue, 15 Jan 2002 14:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290266AbSAOThW>; Tue, 15 Jan 2002 14:37:22 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:53891 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S290265AbSAOThI>; Tue, 15 Jan 2002 14:37:08 -0500
Message-ID: <00a301c19dfc$26928320$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Kent Borg" <kentborg@borg.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <005901c19dec$59a89e30$0201a8c0@HOMER> <20020115125702.B8840@borg.org>
Subject: Re: Why not "attach" patches?
Date: Tue, 15 Jan 2002 20:38:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Kent Borg" <kentborg@borg.org>
To: "Martin Eriksson" <nitrax@giron.wox.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, January 15, 2002 6:57 PM
Subject: Re: Why not "attach" patches?


> On Tue, Jan 15, 2002 at 06:44:58PM +0100, Martin Eriksson wrote:
> > Why do many of you not _attach_ patches instead of merging them with the
> > mail? It's so much cleaner and easier to have a "xxx-yyy.patch" file
> > attached to the mail which can be saved in an appropriate directory.
Also,
> > the whitespace is always retained that way.
>
> It is nice to have the patch to look at when looking at the mail, and
> it is nice to have the mail to look at when looking at the patch.
>
> One of the features of patch is that you can save the whole patch
> e-mail to a file and use it directly; patch is willing to skip over
> all the e-mail headers and regular looking text until it sees
> something that looks like a patch.  Handy, huh?

Aaah.. DOH! That was just what was lurking in the back of my head, but the
thinking part of the brain didn't quite grasp it. Of course "patch" will
skip "no-patch" text instead of crapping out. Hell, if I'd designed the
"patch" program that behaviour would have been one of the first things to
implement.

Sorry for the LKML spam then =) but ain't it nice with one of these
"easy-to-answer" mails from time to time...?

/Martin Eriksson

PS. I really hate OE. Anyone care to recommend THE Windoze Mail+News reader
program, with EXTREME filtering capabilities AND not looking like crap?

