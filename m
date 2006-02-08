Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbWBHESt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbWBHESt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWBHESt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:18:49 -0500
Received: from xenotime.net ([66.160.160.81]:17864 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932190AbWBHESs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:18:48 -0500
Date: Tue, 7 Feb 2006 20:19:23 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andi Kleen <ak@suse.de>
Cc: haveblue@us.ibm.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, herbert@13thfloor.at, serue@us.ibm.com,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, ssouhlal@freebsd.org,
       frankeh@watson.ibm.com, clg@fr.ibm.com, mrmacman_g4@mac.com, dev@sw.ru,
       gkurz@fr.ibm.com, torvalds@osdl.org, akpm@osdl.org, greg@kroah.com,
       riel@redhat.com, kuznet@ms2.inr.ac.ru, saw@sawoct.com, dev@openvz.org,
       benh@kernel.crashing.org, jgarzik@pobox.com, trond.myklebust@fys.uio.no,
       jes@sgi.com
Subject: Re: [RFC][PATCH 0/20] Multiple instances of the process id
 namespace
Message-Id: <20060207201923.1a97cfd6.rdunlap@xenotime.net>
In-Reply-To: <200602071033.23316.ak@suse.de>
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<1139273294.6189.170.camel@localhost.localdomain>
	<200602071033.23316.ak@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006 10:33:21 +0100 Andi Kleen wrote:

> On Tuesday 07 February 2006 01:48, Dave Hansen wrote:
> > On Mon, 2006-02-06 at 12:19 -0700, Eric W. Biederman wrote:
> > > p.s.  My apologies at the size of the CC list.  It is very hard to tell who
> > > the interested parties are, and since there is no one list we all subscribe
> > > to other than linux-kernel how to reach everyone in a timely manner.  I am
> > > copying everyone who has chimed in on a previous thread on the subject.  If
> > > you don't want to be copied in the future tell and I will take your name off
> > > of my list.
> > 
> > Is it worth creating a vger or OSDL mailing list for these discussions?
> > There was some concern the cc list is getting too large. :)
> 
> No, linux-kernel is fine. It will keep everybody informed, instead of
> small groups doing their own things. But just keep the cc lists short please.
> I'm sure all interested people can get it from l-k.

OK.  (Yes, I have a dream.)

I'd like to see less traffic on lkml, with various things moved off
to other mailing lists.

According to http://marc.theaimsgroup.com/?l=linux-kernel,
Jan. 2006 was a near record month and Feb. is on track to be large also.

---
~Randy
