Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbSAOXeh>; Tue, 15 Jan 2002 18:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289746AbSAOXe1>; Tue, 15 Jan 2002 18:34:27 -0500
Received: from kullstam.ne.mediaone.net ([66.30.137.210]:7051 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S286339AbSAOXeQ>; Tue, 15 Jan 2002 18:34:16 -0500
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Why not "attach" patches?
In-Reply-To: <005901c19dec$59a89e30$0201a8c0@HOMER>
	<20020115125702.B8840@borg.org> <00a301c19dfc$26928320$0201a8c0@HOMER>
Organization: none
Date: 15 Jan 2002 18:34:10 -0500
In-Reply-To: <00a301c19dfc$26928320$0201a8c0@HOMER>
Message-ID: <m2y9iznq8d.fsf@euler.axel.nom>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin Eriksson" <nitrax@giron.wox.org> writes:

> ----- Original Message -----
> From: "Kent Borg" <kentborg@borg.org>
> To: "Martin Eriksson" <nitrax@giron.wox.org>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Tuesday, January 15, 2002 6:57 PM
> Subject: Re: Why not "attach" patches?
> 
> 
> > On Tue, Jan 15, 2002 at 06:44:58PM +0100, Martin Eriksson wrote:
> > > Why do many of you not _attach_ patches instead of merging them with the
> > > mail? It's so much cleaner and easier to have a "xxx-yyy.patch" file
> > > attached to the mail which can be saved in an appropriate directory.
> Also,
> > > the whitespace is always retained that way.
> >
> > It is nice to have the patch to look at when looking at the mail, and
> > it is nice to have the mail to look at when looking at the patch.
> >
> > One of the features of patch is that you can save the whole patch
> > e-mail to a file and use it directly; patch is willing to skip over
> > all the e-mail headers and regular looking text until it sees
> > something that looks like a patch.  Handy, huh?
> 
> Aaah.. DOH! That was just what was lurking in the back of my head, but the
> thinking part of the brain didn't quite grasp it. Of course "patch" will
> skip "no-patch" text instead of crapping out. Hell, if I'd designed the
> "patch" program that behaviour would have been one of the first things to
> implement.
> 
> Sorry for the LKML spam then =) but ain't it nice with one of these
> "easy-to-answer" mails from time to time...?
> 
> /Martin Eriksson
> 
> PS. I really hate OE. Anyone care to recommend THE Windoze Mail+News reader
> program, with EXTREME filtering capabilities AND not looking like
> crap?

dunno if you feel it looks like crap or not, but i recommend
gnus/emacs.  it works great on both windows and linux.  it can split
mail into buckets/folders.  it has better than filtering, it has
SCORING.

i am not sure what to do about the ubiquitous sendmail/mailbox ^From
braindamage though.  qmail using maildir doesn't suffer from it.

-- 
J o h a n  K u l l s t a m
[kullstam@mediaone.net]
