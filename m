Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUEFQ2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUEFQ2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 12:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUEFQ2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 12:28:34 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:55944
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261186AbUEFQ2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 12:28:31 -0400
From: Rob Landley <rob@landley.net>
To: romano@dea.icai.upco.es
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
Date: Thu, 6 May 2004 11:22:48 -0500
User-Agent: KMail/1.5.4
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <20040429064115.9A8E814D@damned.travellingkiwi.com> <200405042018.23043.rob@landley.net> <20040506154328.GA6245@pern.dea.icai.upco.es>
In-Reply-To: <20040506154328.GA6245@pern.dea.icai.upco.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405061122.48644.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 May 2004 10:43, Romano Giannetti wrote:
> On Tue, May 04, 2004 at 08:18:23PM -0500, Rob Landley wrote:
> > I'm one of the people for whom Patrick's suspend worked and yours didn't.
> >  Now I've been busy with other things for a couple months (Penguicon 2.0
> > went quite well, by the way), and there's talk of yanking Patrick's
> > suspend code from the kernel.  Right, so I've got to deal with this.  I
> > can't say I'm thrilled, but I DO want to continue to be able to suspend
> > my laptop.
>
> Hi!
>     Just a couple of lines to tell you that I was convinced of the same (PM
>     works, SWSUSP-vanilla no). But from 2.6.3 --- to which I am stuck, had
>     no time to play, just to work, with my laptop till then --- swsusp
> works quite well (modulo pcmcia modem sometime getting stuck after resume
> and sometime no, misteries of life). Pavel told me that if PMDISK worked,
> SWSUSP (vanilla) should work, too, and he was right (tm).
>
>     The other way around is trying suspend2, given that Nigel is very
>     responsive; it will be the first thing I'll try again when having a
>     little time after IMTC04. It didn't work one month ago, but Nigel
> thinks he have fixed it.
>
>     By the way, I have a vaio FX701.

Thinkpad iSeries of some kind here.  It didn't work in 2.6.5, but I'll give 
2.6.6 a try and report back then...

The last one I _know_ worked was 2.6.2, but then I skipped 3 and 4.  Too 
busy...

I'm happy to debug problems with stuff I actually use, modulo the whole "too 
busy" thing...

Rob

