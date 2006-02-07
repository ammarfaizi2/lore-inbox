Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWBGJlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWBGJlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWBGJle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:41:34 -0500
Received: from mx1.suse.de ([195.135.220.2]:14782 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932458AbWBGJlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:41:09 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC][PATCH 0/20] Multiple instances of the process id namespace
Date: Tue, 7 Feb 2006 10:33:21 +0100
User-Agent: KMail/1.8.2
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@freebsd.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com> <1139273294.6189.170.camel@localhost.localdomain>
In-Reply-To: <1139273294.6189.170.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071033.23316.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 01:48, Dave Hansen wrote:
> On Mon, 2006-02-06 at 12:19 -0700, Eric W. Biederman wrote:
> > p.s.  My apologies at the size of the CC list.  It is very hard to tell who
> > the interested parties are, and since there is no one list we all subscribe
> > to other than linux-kernel how to reach everyone in a timely manner.  I am
> > copying everyone who has chimed in on a previous thread on the subject.  If
> > you don't want to be copied in the future tell and I will take your name off
> > of my list.
> 
> Is it worth creating a vger or OSDL mailing list for these discussions?
> There was some concern the cc list is getting too large. :)

No, linux-kernel is fine. It will keep everybody informed, instead of
small groups doing their own things. But just keep the cc lists short please.
I'm sure all interested people can get it from l-k.

-Andi
