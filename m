Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWEMRNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWEMRNT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 13:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWEMRNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 13:13:18 -0400
Received: from xenotime.net ([66.160.160.81]:60083 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750705AbWEMRNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 13:13:18 -0400
Date: Sat, 13 May 2006 10:15:45 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: gleb@minantech.com, mingo@elte.hu, akpm@osdl.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 00/02] update to Document futex PI design
Message-Id: <20060513101545.8afeb220.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.58.0605131303100.27751@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com>
	<20060510101729.GB31504@elte.hu>
	<Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com>
	<20060510124600.GN5319@minantech.com>
	<Pine.LNX.4.58.0605100925190.4503@gandalf.stny.rr.com>
	<20060513100142.d437a6b2.rdunlap@xenotime.net>
	<Pine.LNX.4.58.0605131303100.27751@gandalf.stny.rr.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 May 2006 13:07:46 -0400 (EDT) Steven Rostedt wrote:

> 
> On Sat, 13 May 2006, Randy.Dunlap wrote:
> 
> > On Wed, 10 May 2006 09:27:48 -0400 (EDT) Steven Rostedt wrote:
> >
> > >
> > > Andrew,
> > >
> > > The following two patches update the rt-mutex-design.txt document.
> > >
> > > The first one simply removes all the tabs that I had in that document.
> > > Since it's a document and not code, tabs are not really appropiate.
> >
> > I think that lots of people would not agree with that sentiment.
> > Documentation/*.txt has approximately 8800 lines with tabs in them
> > (just top-level Doc/*.txt, not sub-directories).
> 
> Yeah, but I have few ascii art graphs, as well as notes and points, that
> would look funny if you don't have 8 character tabs.

OK, spaces do make sense for that IMO.
But tabs are perfectly fine in text indentations.

> But If the standand is to have tabs, then I would convert all 8
> consecutive spaces to use tabs.  But the original document had a mix of
> tabs and spaces that just looked horrible on different editors.  So I
> decided to use spaces since that is more consistent, in the look.

Sure, mixing is often ugly/bad.

> But if this is not the norm, I'll supply a patch, otherwise I'll let it
> be.

Who can answer that?

---
~Randy
