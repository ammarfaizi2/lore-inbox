Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRAPR0Z>; Tue, 16 Jan 2001 12:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131234AbRAPR0H>; Tue, 16 Jan 2001 12:26:07 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:43921 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S129523AbRAPR0A>; Tue, 16 Jan 2001 12:26:00 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: adelton
From: adelton@fi.muni.cz (Honza Pazdziora)
Subject: Re: Linux not adhering to BIOS Drive boot order?
User-Agent: slrn/0.9.6.2 (IRIX)
Message-ID: <G79MBA.BID@news.muni.cz>
Date: Tue, 16 Jan 2001 17:09:10 GMT
X-Nntp-Posting-Host: nemesis.fi.muni.cz
Reply-To: adelton@informatics.muni.cz
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95193@ATL_MS1>
Organization: Faculty of Informatics, Masaryk University, Brno
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001 16:51:38 GMT, Venkatesh Ramamurthy <Venkateshr@ami.com> wrote:
> 	[Venkatesh Ramamurthy]  Just think an end-user fuguring out this!!!!
> Asking him to change PCI slots and trying it out. My point is the end user
> should not worry about all this. All he does is plugs a new different/ same
> type of card, and gets it going. Why should the linux kernel force the user
> to change the PCI slots. Will this not make it more user - unfriendly

And so what you suggest ... is?

If the system allows variable order of initialization and you want
fixed order, they you have to enter some information to fixate it.

Is plugging new SCSI card and "end user task"?

-- 
------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
   .project: Perl, DBI, Oracle, MySQL, auth. WWW servers, MTB, Spain.
Petition for a Software Patent Free Europe http://petition.eurolinux.org
------------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
