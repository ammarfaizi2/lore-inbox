Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWBGFRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWBGFRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 00:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWBGFRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 00:17:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15751 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964983AbWBGFRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 00:17:25 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 0/20] Multiple instances of the process id
 namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<1139273294.6189.170.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 22:14:08 -0700
In-Reply-To: <1139273294.6189.170.camel@localhost.localdomain> (Dave
 Hansen's message of "Mon, 06 Feb 2006 16:48:13 -0800")
Message-ID: <m14q3bu4wv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Mon, 2006-02-06 at 12:19 -0700, Eric W. Biederman wrote:
>> p.s.  My apologies at the size of the CC list.  It is very hard to tell who
>> the interested parties are, and since there is no one list we all subscribe
>> to other than linux-kernel how to reach everyone in a timely manner.  I am
>> copying everyone who has chimed in on a previous thread on the subject.  If
>> you don't want to be copied in the future tell and I will take your name off
>> of my list.
>
> Is it worth creating a vger or OSDL mailing list for these discussions?
> There was some concern the cc list is getting too large. :)
>
> If yes, would "linux-containers" be an appropriate name?

I have think we can wait until the current discussion is over, as I have
not received any complaints yet.  

For ongoing maintenance of the future in kernel implementation I think
it is worth setting something up.

Eric
