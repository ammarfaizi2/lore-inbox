Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132947AbRDUWAY>; Sat, 21 Apr 2001 18:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132949AbRDUWAP>; Sat, 21 Apr 2001 18:00:15 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:31505 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S132947AbRDUWAJ>; Sat, 21 Apr 2001 18:00:09 -0400
Date: Sat, 21 Apr 2001 14:59:46 -0700 (PDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: Request for comment -- a better attribution system
In-Reply-To: <200104212023.f3LKN7P188973@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.32.0104211456540.4237-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Eric ,

On Sat, 21 Apr 2001, Albert D. Cahalan wrote:
> Eric S. Raymond writes:
> > This is a proposal for an attribution metadata system in the Linux
> > kernel sources.  The goal of the system is to make it easy for
> > people reading any given piece of code to identify the responsible
> > maintainer.  The motivation for this proposal is that the present
> > system, a single top-level MAINTAINERS file, doesn't seem to be
> > scaling well.
> It is nice to have a single file for grep. With the proposed
> changes one would sometimes need to grep every file.

	Find . -name "*Some-Name*" -type f -print | xargs grep 'Some-Info'
	Hate answering with just one line of credible info , But .
		Hth ,  JimL
       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

